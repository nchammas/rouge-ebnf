require_relative 'spec_helper'

class RougeEBNFTest < Minitest::Test
  def test_extension_guess_lark
    assert_equal Rouge::Lexer.guess(filename: 'foo.lark'), RougeEBNF::EBNF
  end

  def test_extension_guess_ebnf
    assert_equal Rouge::Lexer.guess(filename: 'foo.ebnf'), RougeEBNF::EBNF
  end

  def test_mimetype_guess
    assert_equal Rouge::Lexer.guess(mimetype: 'text/x-ebnf'), RougeEBNF::EBNF
  end

  def test_alias
    assert_equal Rouge::Lexer.find('lark'), RougeEBNF::EBNF
  end

  def test_lexes_demo
    demo_text = RougeEBNF::EBNF.instance_variable_get(:@demo)
    fulltext = []
    RougeEBNF::EBNF.lex(demo_text) do |tok, text|
      fulltext << text
      refute_equal tok.qualname, 'Error'
    end
    assert_equal fulltext.join, demo_text
  end

  def test_lexes_sample
    sample_text = File.read("#{__dir__}/sample.ebnf")
    fulltext = []
    RougeEBNF::EBNF.lex(sample_text) do |tok, text|
      fulltext << text
    end
    assert_equal fulltext.join, sample_text
  end

  def test_tree_shaping_prefixes
    [
      "_NL : /\\r?\\n/",        # _TERMINAL: filtered (excluded from parse tree)
      '!atom : "(" expr ")"',   # !rule: keeps all terminals in tree
      '?value : NUMBER | name', # ?rule: inlined if single child
    ].each do |src|
      RougeEBNF::EBNF.lex(src) do |tok, text|
        refute_equal tok.qualname, 'Error'
      end
    end
  end
end
