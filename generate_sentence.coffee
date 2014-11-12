
model = require('./source/models/bodyslam.json')

SentenceGenerator = require('./lib/sentence_generator')

g = new SentenceGenerator(model)

for i in [1..100]
  console.log g.generate()

