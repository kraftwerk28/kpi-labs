const knex = require('knex')

const conn = knex({
  connection: {
    database: 'olap_lab3',
    user: 'kraftwerk28',
    password: '271828'
  },
  client: 'pg'
})

// const movies = require(__dirname + '/json/IMDb movies.json')

async function makeMoviesSchema() {
  await conn.schema.dropTableIfExists('facts')
  await conn.schema.dropTableIfExists('movies')
  await conn.schema.dropTableIfExists('persons')
  await conn.schema.dropTableIfExists('jobs')
  await conn.schema.dropTableIfExists('ratings')
  await conn.schema.dropTableIfExists('countries')
  await conn.schema.dropTableIfExists('languages')
  await conn.schema.dropTableIfExists('companies')

  await conn.schema.createTable('facts', t => {
    t.string('movie_id', 10)
    t.string('person_id', 10)
    t.integer('job_id')
    t.integer('rate_id')
  })

  await conn.schema.createTable('movies', t => {
    t.string('movie_id', 10)
      .notNullable()
      .primary()
    t.string('title', 256)
    t.string('original_title', 256)
    t.integer('year')
    t.string('date_published', 16)
    t.integer('duration')
    t.text('description')
    t.float('avg_vote')
    t.integer('votes')
    t.float('reviews_from_users')
    t.float('reviews_from_critics')

    // references for foreign keys
    t.integer('country_id')
    t.integer('lang_id')
    t.integer('company_id')
  })

  await conn.schema.createTable('persons', t => {
    t.string('person_id', 10)
      .notNullable()
      .primary()
    t.string('name', 128)
    t.string('birth_name', 128)
    t.float('height')
    t.text('bio')
    t.integer('birth_year')
    t.string('birth_details', 256)
    t.string('date_of_birth', 16)
    t.string('place_of_birth', 256)
    t.integer('spouses')
  })

  await conn.schema.createTable('jobs', t => {
    t.increments('job_id').primary()
    t.enu(
      'job_name',
      ['actor', 'producer', 'soundtrack', 'writer', 'actress', 'director'],
      { enumName: 'job_type', useNative: true }
    )
  })

  await conn.schema.createTable('ratings', t => {
    t.increments('rate_id').primary()
    t.float('avg_vote')
  })

  // await conn.schema.alterTable('facts', t => {
  //   t.string('movie_id', 10)
  //     .references('movie_id')
  //     .inTable('movies')
  //     .onDelete('CASCADE')
  //     .alter()
  //   t.string('person_id', 10)
  //     .references('person_id')
  //     .inTable('persons')
  //     .onDelete('CASCADE')
  //     .alter()
  //   t.integer('job_id')
  //     .references('job_id')
  //     .inTable('jobs')
  //     .onDelete('CASCADE')
  //     .alter()
  //   t.integer('rate_id')
  //     .references('rate_id')
  //     .inTable('ratings')
  //     .onDelete('CASCADE')
  //     .alter()
  // })

  await conn.schema.createTable('countries', t => {
    t.increments('country_id')
    t.string('country_name', 64)
  })

  await conn.schema.createTable('languages', t => {
    t.increments('lang_id')
    t.string('lang_name', 64)
  })

  await conn.schema.createTable('companies', t => {
    t.increments('company_id')
    t.string('company_name', 64)
  })

  // await conn.schema.alterTable('movies', t => {
  //   t.integer('country_id')
  //     .references('country_id')
  //     .inTable('countries')
  //     .onDelete('CASCADE')
  //     .alter()
  //   t.integer('lang_id')
  //     .references('lang_id')
  //     .inTable('languages')
  //     .onDelete('CASCADE')
  //     .alter()
  //   t.integer('company_id')
  //     .references('company_id')
  //     .inTable('companies')
  //     .onDelete('CASCADE')
  //     .alter()
  // })
}

async function transferData() {}

async function main() {
  await makeMoviesSchema()

  await conn.destroy()
}

process.on('unhandledRejection', e => {
  console.error(e)
  process.exit(1)
})

main()
