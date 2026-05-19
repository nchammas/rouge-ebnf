#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rouge'
require_relative 'lib/rouge-ebnf'

fname = ARGV[0] || "#{__dir__}/spec/sample.ebnf"

text = if fname == 'demo'
  RougeEBNF::EBNF.instance_variable_get(:@demo)
else
  File.read(fname)
end

Rouge::Lexer.enable_debug!

if ENV['DEBUG'] == '1'
  lexer = RougeEBNF::EBNF.new(debug: true)
  formatter = 'null'
else
  lexer = RougeEBNF::EBNF.new
  formatter = 'terminal_truecolor'
end

Rouge.highlight(text, lexer, formatter) { |chunk| print chunk }
