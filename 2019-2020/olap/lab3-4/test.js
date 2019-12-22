'use strict'

const knex = require('knex')
const kn = knex({
  connection: {
    database: 'olap_lab3',
    user: 'kraftwerk28',
    password: '271828'
  },
  client: 'pg'
})

async function main() {
  console.dir(
    await kn('facts')
      .select('*')
      .whereNotIn('movie_id', kn('movies').select('movie_id'))
      .count()
  )
  
  await kn.destroy()
}

main().catch(err => {
  console.error(err)
  kn.destroy()
})
