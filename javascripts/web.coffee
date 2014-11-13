
$ = require('jquery')

$ ->
  $('#settings').on 'submit', (e) ->
    e.preventDefault()
    work(
      workerPath: resolve($(this).attr('data-worker-path'))
      paragraphs: +$('#paragraphs').val() or 1
      sentences: +$('#sentences').val() or 10
      model: resolve("models/#{$('#model').val()}.json")
    )(
      text: (text) ->
        $('#result').append(text)
      info: (info) ->
        $('#info').html info.description
    )
        

resolve = (href) ->
  a = document.createElement('a')
  a.href = href
  a.href

work = (options) -> (callbacks) ->
  worker = new Worker(options.workerPath)
  worker.onmessage = (e) ->
    for command, value of e.data
      callbacks[command]?(value)
  worker.postMessage options

###
model = require('../source/models/bodyslam.json')

g = new SentenceGenerator(model)

$ ->
  generate = ->
    $('#result').append g.generate()
  setInterval generate, 100
###

