
require 'trie'

describe Trie do

  # A trie is the number of token sequence occurence.
  # For interoperability with JavaScript, we choose the key to be string.
  #
  #     :max: 4
  #     :data:
  #       1:
  #         "2,3,4,5": 5
  #         "3,4,5": 5
  #         "4,5": 5
  #         "5": 5
  #
  # In the example, there are 5 occurences of the tokens 2, 3, 4, 5, 1.

  describe "::from_sequence" do
    it "should create a trie from token sequence" do
      result = Trie.from_sequence([2, 3, 4, 5, 1], max: 4)
      expect(result[:max]).to eq 4
      expect(result[:data][1]).to eq({
        "2,3,4,5" => 1,
        "3,4,5"   => 1,
        "4,5"     => 1,
        "5"       => 1,
      })
    end
  end

end
