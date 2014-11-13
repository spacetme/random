
$ = require('jquery')

$ ->
  $('#settings').on 'submit', (e) ->
    e.preventDefault()
    $('#info').html('')
    $('#result').html('<p></p>')
    work(
      workerPath: resolve($(this).attr('data-worker-path'))
      paragraphs: +$('#paragraphs').val() or 1
      sentences: +$('#sentences').val() or 10
      model: resolve("models/#{$('#model').val()}.json")
    )(
      text: (text) ->
        $('#result p:last').append(text)
      newParagraph: (text) ->
        console.log('new paragraph!')
        $('#result').append('<p></p>')
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
      console.log command
      callbacks[command]?(value)
  worker.postMessage options

