
require 'document'

describe Document do

  # A document is a collection of words and token IDs.
  #
  #     :words:
  #       - happy
  #       - birthday
  #       - to
  #       - you
  #     :sequence: [
  #         0, -1, 1, -1, 2, -1, 3, -1,
  #         0, -1, 1, -1, 2, -1, 3, -1,
  #         0, -1, 1, -1, 0, -1, 1, -1
  #         0, -1, 1, -1, 2, -1, 3 ]
  #
  # Here, the each sequence element is the index,
  # or -1 for special token such as space.

  describe "::create" do

    it "should create a document from tokens" do
      tokens = [
        'happy', ' ', 'birthday', ' ', 'to', ' ', 'you', ' ',
        'happy', ' ', 'birthday', ' ', 'to', ' ', 'you', ' ',
        'happy', ' ', 'birthday', ' ', 'happy', ' ', 'birthday', ' ',
        'happy', ' ', 'birthday', ' ', 'to', ' ', 'you' ]
      document = Document.from_tokens(tokens)
      expect(document[:words].sort).to eq ['birthday', 'happy', 'to', 'you']
      expect(document[:sequence].sort.uniq.length).to eq 5
    end

  end

end
