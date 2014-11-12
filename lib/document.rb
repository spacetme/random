
module Document

  # :: [ *String ] -> { words: [ *String ], tokens: [ *Integer ] }
  def self.from_tokens(tokens)
    words = [ ]
    word_map = { }
    sequence = tokens.map do |token|
      if token == ' '
        -1
      else
        word_map[token] ||= begin
          index = words.length
          words << token
          index
        end
      end
    end
    { words: words, sequence: sequence }
  end

end
