# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "rouge-ebnf"
  s.version     = "0.1.0"
  s.authors     = ["Nicholas Chammas"]
  s.summary     = "Lark-style EBNF grammar notation support for Rouge"
  s.description = "A Rouge plugin adding syntax highlighting for Lark-style EBNF grammar files."
  s.homepage    = "https://github.com/nchammas/rouge-ebnf"
  s.licenses    = ["MIT"]

  s.required_ruby_version = ">= 3.4"

  s.files = Dir["Gemfile", "LICENSE", "rouge-ebnf.gemspec", "lib/**/*.rb"]

  s.add_dependency "rouge", "~> 4.0"
end
