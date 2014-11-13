
global.window = global

SentenceGenerator = require('../lib/sentence_generator')


global.onmessage = (event) ->

  options = event.data

  xhr = new XMLHttpRequest
  xhr.onprogress = (e) -> onprogress(e)
  xhr.onload = -> onload(xhr, options)
  xhr.open 'GET', options.model, true
  xhr.send null


onprogress = (e) ->

  if e.lengthComputable
    postMessage({ progress: (e.loaded / e.total) * 0.3 })


onload = (xhr, options) ->

  model = JSON.parse(xhr.responseText)

  generator = new SentenceGenerator(model)
  postMessage({ info: model.info })

  paragraphs = options.paragraphs
  sentences = options.sentences

  totalSentences = paragraphs * sentences
  completedSentences = 0
  wordsInIncompleteSentence = 0

  loop
    text = generator.generate()
    if text is " "
      wordsInIncompleteSentence = 0
      completedSentences += 1
      sentences -= 1
      if sentences is 0
        paragraphs -= 1
        if paragraphs is 0
          break
        else
          postMessage({ newParagraph: null })
          sentences = options.sentences
          continue
    else
      wordsInIncompleteSentence += 1
    progress = (completedSentences + (1 - Math.exp(wordsInIncompleteSentence / -4))) / totalSentences
    postMessage({ text, progress: 0.3 + progress * 0.7 })

  postMessage({ progress: 1 })

