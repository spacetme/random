
$     = require('jquery')
Bacon = require('bacon')

$ ->
  $('#settings').on 'submit', (e) ->
    e.preventDefault()
    work(
      workerPath: $(this).attr('data-worker-path')
      paragraphs: +$('#paragraphs').val() or 1
      sentences: +$('#sentences').val() or 10
      model: "models/#{$('#model').val()}.json"
    )
      initialize: ->
        $('#progress').css('width', "0%")
        $('#info').html('')
        $('#result').html('<p class="text-center">[loading model data]</p>')
      loadProgress: (progress) ->
        $('#progress').css('width', "#{Math.round(progress * 1000) / 10}%")
          .attr('data-progress-type', 'load')
      onload: ->
        $('#result').html('<p class="text-center">[starting worker]</p>')
      begin: ->
        $('#result').html('<p></p>')
      text: (text) ->
        $('#result p:last').append(text)[0].normalize()
      progress: (progress) ->
        $('#progress').css('width', "#{Math.round(progress * 1000) / 10}%")
          .attr('data-progress-type', 'generate')
      newParagraph: (text) ->
        console.log('new paragraph!')
        $('#result').append('<p></p>')
      info: (info) ->
        $('#info').html info.description
      end: ->

resolve = (href) ->
  a = document.createElement('a')
  a.href = href
  a.href

MODEL_CACHE = { }

loadModel = ({ model }) -> (callbacks) ->
  return callbacks.onload?(MODEL_CACHE[model]) if MODEL_CACHE[model]
  xhr = new XMLHttpRequest
  xhr.onload = ->
    modelObject = MODEL_CACHE[model] = JSON.parse(xhr.responseText)
    callbacks.onload?(modelObject)
  xhr.onprogress = (e) ->
    if e.lengthComputable
      callbacks.onprogress?(e.loaded / e.total)
  xhr.open 'GET', model, true
  xhr.send null

work = (options) -> (callbacks) ->
  callbacks.initialize?()
  loadModel(model: options.model)
    onload: (model) ->
      callbacks.onload?()
      worker = new Worker(options.workerPath)
      worker.onmessage = (e) ->
        for command, value of e.data
          callbacks[command]?(value)
      worker.postMessage { options, model }
    onprogress: (progress) ->
      callbacks.loadProgress(progress)


