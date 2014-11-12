
{ mapValues } = require('lodash')

module.exports = class SentenceGenerator

  constructor: (@model) ->
    @history = [-1]
    @wordCount = 0
    @sentenceLength = 0

  generate: ->
    @targetSentenceLength ||= randomSentenceLength()
    spaceWeightFactor = Math.pow(Math.max(@sentenceLength - @targetSentenceLength, 0) / 2, 2)
    weights = weightsFor(@history, @model, space: spaceWeightFactor)
    key = pick(weights)
    if +key is -1
      @sentenceLength = 0
    else
      @sentenceLength += 1
    @history.push(key)
    if +key is -1
      " "
    else
      @model.words[key]

randomSentenceLength = ->
  5 + Math.floor(Math.random() * 10)


weightsFor = (history, model, space: space) ->

  max = Math.min(history.length, model.trie.max)

  weights = for key, statistic of model.trie.data
    weight = Math.pow(0.01, 2)
    for n in [1..max]
      weight += Math.pow((statistic[history.slice(-n)] or 0) * Math.pow(n, 2), 2)
    [key, weight * (if +key is -1 then space else 1)]

  weights.sort ([_1, a], [_2, b]) -> a - b

  value = 0
  for current in weights
    value += (current[1] - value) / 4
    current[1] = value

  weights

pick = (weights) ->
  total = 0
  total += weight for [key, weight] in weights
  picked = Math.random() * total
  current = 0
  for [key, weight] in weights
    current += weight
    return key if picked <= current

###
#  weights = trie.map do |word, hash|
    weight = 0.01 ** 2
    (1..history.length).each do |n|
      weight += (hash[history.last(n)] * (n ** 2)) ** 2
    end
    [word, weight * (word == " " ? space_prob : 1.0)]
  end

  # smoothen the weight
  weights.sort_by!(&:last)
  value = 0.0
  weights.each do |array|
    value += (array[1] - value) / 5.0
    array[1] = value
  end

  weights
###

