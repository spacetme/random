
require 'yaml'

require 'tokenizer'
require 'document'
require 'trie'

module CorpusConvertor

  def self.convert(pathname)

    text = File.read(File.join(pathname, 'corpus.txt'))
    info = YAML.load(File.read(File.join(pathname, 'info.yml')))

    tokens = Tokenizer.tokenize(text)
    document = Document.from_tokens(tokens)
    trie = Trie.from_sequence(document[:sequence])

    { info: info, trie: trie, words: document[:words] }

  end

end
