
global.window = global

SentenceGenerator = require('../lib/sentence_generator')

global.onmessage = (event) ->
  options = event.data
  xhr = new XMLHttpRequest
  xhr.open 'GET', options.model, false
  xhr.send null
  model = JSON.parse(xhr.responseText)
  generator = new SentenceGenerator(model)
  postMessage({ info: model.info })
  for i in [1..100]
    postMessage({ text: generator.generate() })

