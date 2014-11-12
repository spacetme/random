
require 'tokenizer'

describe Tokenizer do

  describe 'tokenize' do

    it "should tokenize text" do
      expect(Tokenizer.tokenize('สวัสดีครับ').to_a).to eq %w(สวัสดี ครับ)
      expect(Tokenizer.tokenize(' สวัสดีครับ').to_a).to eq %w(สวัสดี ครับ)
      expect(Tokenizer.tokenize('สวัสดีครับ  ').to_a).to eq %w(สวัสดี ครับ)
    end

    it "should preserve one space" do
      expect(Tokenizer.tokenize('สวัสดี ครับ').to_a).to eq ['สวัสดี', ' ', 'ครับ']
      expect(Tokenizer.tokenize('สวัสดี  นะ ครับ').to_a).to eq ['สวัสดี', ' ', 'นะ', ' ', 'ครับ']
    end

  end

end

