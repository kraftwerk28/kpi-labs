const path = require('path');
const fs = require('fs');
const knex = require('knex');
const csv = require('csv-parser');

function log(data) {
  if (typeof data === 'object') {
    console.dir(data, { depth: 10 });
  } else {
    const str = data.toString();
    console.log('> %s', str[0].toUpperCase() + str.slice(1));
  }
}

const kn = knex({
  connection: {
    database: 'olap_lab3',
    user: 'kraftwerk28',
    password: '271828'
  },
  client: 'pg'
});

const CSV_PATH = 'data/';

const parseNum = d => (isNaN(+d) ? null : +d);

const MOVIES_MAP = [
  ['imdb_title_id', 'movie_id'],
  'title',
  'original_title',
  ['year', null, parseNum],
  'date_published',
  ['duration', null, parseNum],
  'description',
  ['avg_vote', null, parseNum],
  ['votes', null, parseNum],
  ['reviews_from_users', null, parseNum],
  ['reviews_from_critics', null, parseNum]
];

const NAMES_MAP = [
  ['imdb_name_id', 'person_id'],
  'name',
  'birth_name',
  ['height', null, parseNum],
  'bio',
  ['birth_year', null, parseNum],
  'birth_details',
  'date_of_birth',
  'place_of_birth',
  ['spouses', null, parseNum]
];

function fetchCSV(filename) {
  return new Promise((res, rej) => {
    let data = [];
    fs.createReadStream(path.resolve(CSV_PATH, filename))
      .pipe(csv())
      .on('headers', headers => {
        console.log('headers:', headers);
      })
      .on('data', ch => data.push(ch))
      .on('end', () => res(data))
      .on('error', rej);
  });
}

function fetchRows(filename, skip = 0) {
  return new Promise((res, rej) => {
    const stream = fs
      .createReadStream(path.resolve(CSV_PATH, filename))
      .pipe(csv())
      .on('data', row => {
        if (skip-- > 0) return;
        res(row);
        stream.end();
      })
      .on('error', rej);
  });
}

async function reduceRows(filename, rowCallback) {
  const promises = [];
  const prCb = (res, rej) => {
    const stream = fs
      .createReadStream(path.resolve(CSV_PATH, filename))
      .pipe(csv())
      .on('headers', headers => {
        console.log('headers:', headers);
      })
      .on('data', row => {
        const promise = rowCallback(row, () => {
          stream.end();
        });
        promises.push(promise);
      })
      .on('end', () => res())
      .on('error', rej);
  };
  await new Promise(prCb);
  await Promise.all(promises);
}

const mapRow = (mapObject, row) =>
  mapObject.reduce((acc, c) => {
    if (Array.isArray(c)) {
      if (c.length === 2) {
        acc[c[1]] = row[c[0]];
      }
      if (c.length === 3) {
        if (c[1] === null) {
          acc[c[0]] = c[2](row[c[0]]);
        } else {
          acc[c[1]] = c[2](row[c[0]]);
        }
      }
    } else {
      acc[c] = row[c];
    }
    return acc;
  }, {});

async function loadMovies({ movies }) {
  const mapped = movies.map(row => mapRow(MOVIES_MAP, row));
  await kn.batchInsert('movies', mapped);
}

async function loadNames({ names }) {
  const mapped = names
    .filter(n => n.imdb_name_id)
    .map(row => mapRow(NAMES_MAP, row));
  await kn.batchInsert('persons', mapped);
}

async function loadJobs() {}

async function loadFacts() {
  await kn('jobs').truncate();
  const jobsMap = new Map();
  let count = 0;

  const trx = await kn.transaction();
  const rollbackCb = err => {
    console.error(err);
    // trx.rollback();
    process.exit(1);
  };

  await reduceRows('IMDb title_principals.csv', async row => {
    const job = row.category;
    if (!job) return Promise.resolve();
    if (!jobsMap.has(job)) {
      jobsMap.set(job, null);
      const [ins] = await trx('jobs')
        .insert({ job_name: job }, '*')
        .catch(rollbackCb);
      jobsMap.set(ins.job_name, ins.job_id);
    }
    // if (row.imdb_name_id && row.imdb_name_id.length) {
    //   await trx('facts')
    //     .update({ job_id: jobsMap.get(job) })
    //     .where('person_id', row.imdb_name_id)
    //     .then(count => console.log(`Updated ${count} facts`))
    //     .catch(rollbackCb);
    // }
  });
  await trx.commit();
  // const jobs = await kn('jobs').select('*');
  // const jobMap = jobs.reduce((acc, c) => {
  //   acc[c.job_name] = c.job_id;
  //   return acc;
  // }, {});
  // console.log(jobMap);
  // console.log('m to m length:', mov_nam.length);
  // const mapped = mov_nam.map(mn => ({
  //   movie_id: mn.imdb_title_id,
  //   person_id: mn.imdb_name_id,
  //   job_id: jobMap[mn.category] || null
  // }));
  // await kn.batchInsert('facts', mapped);
}

async function untrash() {
  await kn('facts')
    .whereNotIn('movie_id', kn('movies').select('movie_id'))
    .del();
  log('untrashed tables');
}

async function realter() {
  await kn.schema.alterTable('facts', t => {
    t.foreign('movie_id')
      .references('movie_id')
      .inTable('movies')
      .onDelete('CASCADE');
    t.foreign('person_id')
      .references('person_id')
      .inTable('persons')
      .onDelete('CASCADE');
    t.foreign('job_id')
      .references('job_id')
      .inTable('jobs')
      .onDelete('CASCADE');
    t.foreign('rate_id')
      .references('rate_id')
      .inTable('ratings')
      .onDelete('CASCADE');
  });
}

async function extractCountries() {
  await kn('countries').truncate();
  const trx = await kn.transaction();
  const countriesSet = new Set();
  await reduceRows('IMDb movies.csv', async (row, done) => {
    const countries = (row.country || '')
      .split(',')
      .map(c => c.trim())
      .filter(c => c.length > 0);

    await Promise.all(
      countries.map(country => {
        if (countriesSet.has(country)) return Promise.resolve();
        countriesSet.add(country);
        return trx('countries')
          .insert({ country_name: country })
          .whereNotExists(kn('countries').select('country_name'));
      })
    );
  });
  await trx.commit();
}

async function linkCountries() {
  await kn('movies_countries').truncate();
  const countryId = new Map();
  const countries = await kn('countries').select('*');
  countries.forEach(row => countryId.set(row.country_name, row.country_id));

  const trx = await kn.transaction();
  await reduceRows('IMDb movies.csv', (row, done) => {
    const countries = (row.country || '')
      .split(',')
      .map(c => c.trim())
      .filter(c => c.length > 0);
    return Promise.all(
      countries.map(async country =>
        trx('movies_countries').insert({
          movie_id: row.movie_id,
          country_id: countryId.get(country)
        })
      )
    );
  });
  await trx.commit();

  await kn.schema.alterTable('movies_countries', t => {
    t.foreign('country_id')
      .references('country_id')
      .inTable('countries')
      .onDelete('CASCADE');
    t.foreign('movie_id')
      .references('movie_id')
      .inTable('movies')
      .onDelete('CASCADE');
  });
}

async function loadCompanies() {
  await kn('companies').truncate();

  const trx = await kn.transaction();
  const companiesIds = new Map();
  await reduceRows('IMDb movies.csv', async (row, done) => {
    const company = row.production_company;
    if (companiesIds.has(company)) return Promise.resolve();
    const [insertion] = await trx('companies')
      .insert({ company_name: company }, '*')
      .catch(trx.rollback);
    companiesIds.set(insertion.company_name, insertion.company_id);

    await trx('movies')
      .where({ movie_id: row.imdb_title_id })
      .update({
        company_id: companiesIds.get(company)
      })
      .catch(trx.rollback);
  });
  await trx.commit();

  await kn.schema.alterTable('movies', t => {
    t.foreign('company_id')
      .references('company_id')
      .inTable('companies')
      .onDelete('CASCADE');
  });
}

async function loadLanguages() {
  log('loading languages');
  await kn.schema
    .alterTable('movies', t => {
      t.dropForeign(['lang_id']);
    })
    .catch(() => {});
  await kn('languages').truncate();

  const trx = await kn.transaction();
  const langIds = new Map();
  await reduceRows('IMDb movies.csv', async (row, done) => {
    const languages = row.language
      .split(',')
      .map(l => l.trim())
      .filter(l => l.length > 0);
    if (languages.length === 0) return Promise.resolve();
    await Promise.all(
      languages.map(async lang => {
        if (!langIds.has(lang)) {
          langIds.set(lang, null);
          const [insertion] = await trx('languages')
            .insert({ lang_name: lang }, '*')
            .catch(trx.rollback);
          langIds.set(lang, insertion.lang_id);
        }
        // updating movies
        await trx('movies')
          .where({ movie_id: row.imdb_title_id })
          .update({
            lang_id: langIds.get(lang)
          })
          .catch(trx.rollback);
      })
    );
  });
  await trx.commit();

  await kn.schema.alterTable('movies', t => {
    t.foreign('lang_id')
      .references('lang_id')
      .inTable('languages')
      .onDelete('CASCADE');
  });
}

function str2time(str) {
  if (!str || !str.length || str.length < 4) return null;
  if (str.length === 4) {
    return str + '-01-01';
  }
  return str;
}

async function loadTimes() {
  await kn.schema
    .alterTable('times', t => {
      t.dropForeign(['movie_id', 'name_id']);
    })
    .catch(() => {});
  await kn('times').truncate();
  const trx = await kn.transaction();
  await reduceRows('IMDb movies.csv', async row => {
    return trx('times')
      .insert({
        movie_id: row.imdb_title_id,
        time: str2time(row.date_published)
      })
      .catch(trx.rollback);
  });
  console.log('Inserted movies');
  await reduceRows('IMDb names.csv', async row => {
    return trx('times')
      .insert({
        name_id: row.imdb_name_id,
        time: str2time(row.date_of_bitrh)
      })
      .catch(trx.rollback);
  });
  console.log('Inserted persons');
  await trx.commit();

  await kn.schema.alterTable('times', t => {
    t.foreign('movie_id')
      .references('movie_id')
      .inTable('movies')
      .onDelete('CASCADE');
    t.foreign('name_id')
      .references('person_id')
      .inTable('persons')
      .onDelete('CASCADE');
  });
}

async function loadRatings() {
  await kn('ratings').truncate();
  const trx = await kn.transaction();
  await reduceRows('IMDb ratings.csv', async row => {
    await trx('ratings')
      .insert({
        movie_id: row.imdb_title_id,
        weighted_average_vote: parseNum(row.weighted_average_vote),
        total_votes: parseNum(row.total_votes),
        mean_vote: parseNum(row.mean_vote),
        median_vote: parseNum(row.median_vote),
        top1000_voters_rating: parseNum(row.top1000_voters_rating),
        top1000_voters_votes: parseNum(row.top1000_voters_votes)
      })
      .catch(trx.rollback);
  });
  await trx.commit();
  await kn('ratings')
    .whereNotIn('movie_id', kn('movies').select('movie_id'))
    .del();
}

async function main() {
  // console.log(await fetchRows('IMDb title_principals.csv', 6));
  // await loadMovies({ movies })
  // await loadNames({ names })
  await loadFacts();

  // await untrash()
  // await realter()

  // await extractCountries({ movies })
  // await linkCountries();
  // await loadTimes();
  // await loadCompanies();
  // await loadLanguages();
  // await loadRatings();

  await kn.destroy();
}

main().catch(err => {
  console.error(err);
  kn.destroy();
});
