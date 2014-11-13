
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

  paragraphs = options.paragraphs
  sentences = options.sentences

  loop
    text = generator.generate()
    if text is " "
      sentences -= 1
      if sentences is 0
        paragraphs -= 1
        if paragraphs is 0
          break
        else
          postMessage({ newParagraph: null })
          sentences = options.sentences
          continue
    postMessage({ text: text })

