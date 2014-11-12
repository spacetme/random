
module Trie

  DEFAULT_MAX = 4

  def self.from_sequence(sequence, max: DEFAULT_MAX)
    data = { }.tap do |trie|
      hist = [ ]
      sequence.each do |word|
        hist.shift if hist.length > max
        node = (trie[word] ||= Hash.new(0))
        (1..hist.length).each do |n|
          c = hist.last(n).join(',')
          node[c] += 1
        end
        hist << word
      end
    end
    { max: max, data: data }
  end

end
