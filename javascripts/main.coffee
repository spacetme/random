
$ = require('jquery')

model = require('../source/models/bodyslam.json')

SentenceGenerator = require('../lib/sentence_generator')

g = new SentenceGenerator(model)

$ ->
  generate = ->
    $('#result').append g.generate()
  setInterval generate, 100

