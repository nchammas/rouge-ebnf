# frozen_string_literal: true

require 'rouge' unless defined?(Rouge)

module RougeEBNF
  class EBNF < Rouge::RegexLexer
    title "EBNF"
    desc "Lark-style EBNF grammar notation (lark-parser.readthedocs.io)"

    tag 'ebnf'
    aliases 'lark'
    filenames '*.ebnf', '*.lark'
    mimetypes 'text/x-ebnf'

    demo <<~DEMO
      // Arithmetic grammar (Lark-style EBNF)
      start: expr

      expr: expr "+" term  -> add
          | expr "-" term  -> sub
          | term

      term: term "*" factor  -> mul
          | factor

      factor: NUMBER | "(" expr ")"

      NUMBER: /[0-9]+/

      %ignore /\s+/
    DEMO

    state :root do
      rule %r/\s+/m, Text::Whitespace
      rule %r(//[^\n]*), Comment::Single
      rule %r/#[^\n]*/, Comment::Single
      rule %r/%(?:import|ignore|declare|override|extend)\b/, Keyword
      rule %r/[A-Z][A-Z0-9_]*/, Name::Class
      rule %r/_?[a-z][a-zA-Z0-9_]*/, Name
      rule %r/"/, Str::Double, :string
      rule %r/\//, Str::Regex, :regex
      rule %r/\.\./, Operator
      rule %r/->/, Operator
      rule %r/[|+*?~]/, Operator
      rule %r/\./, Punctuation
      rule %r/\d+/, Num::Integer
      rule %r/:/, Punctuation
      rule %r/[(){}\[\],]/, Punctuation
    end

    state :string do
      rule %r/"i?/, Str::Double, :pop!
      rule %r/\\./, Str::Escape
      rule %r/[^\\"]+/, Str::Double
    end

    state :regex do
      rule %r(/[imslux]*), Str::Regex, :pop!
      rule %r/\\./, Str::Escape
      rule %r([^/\\]+), Str::Regex
    end
  end
end
