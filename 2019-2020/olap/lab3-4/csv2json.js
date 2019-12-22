const fs = require('fs')
const path = require('path')
const parse = require('csv-parse/lib/sync')

const files = fs.readdirSync(path.resolve('data/'))

const inputs = files.map(f => fs.readFileSync(path.resolve('data/', f)))

const parsed = inputs.map(i =>
  parse(i, { columns: true })
)

parsed.forEach(p => {
  console.dir(Object.keys(p[0]))
})

// parsed.forEach((obj, idx) => {
//   const fname = path.parse(files[idx]).name
//   const p = path.resolve('json/', fname + '.json')
//   fs.writeFileSync(p, JSON.stringify(obj))
// })
