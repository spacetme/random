
global.window = global

SentenceGenerator = require('../lib/sentence_generator')


global.onmessage = (event) ->

  { options, model } = event.data
  run(model, options)


run = (model, options) ->

  generator = new SentenceGenerator(model)
  postMessage({ info: model.info })

  paragraphs = options.paragraphs
  sentences = options.sentences

  totalSentences = paragraphs * sentences
  completedSentences = 0
  wordsInIncompleteSentence = 0

  postMessage({ begin: null })
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
    postMessage({ text, progress })

  postMessage({ progress: 1, end: null })

