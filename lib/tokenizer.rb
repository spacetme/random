
require 'ffi-icu'

class Tokenizer

  def self.tokenize(text)
    text = text.lines.uniq.join
    text = text.scan(%r((?:\p{Thai})+)).join(' ')
    iterator = ICU::BreakIterator.new(:word, "th_TH")
    iterator.text = text
    iterator.each_cons(2).map do |(f, t)|
      text[f...t]
    end
  end

end
