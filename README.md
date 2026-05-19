# EBNF plugin for Rouge

This is a plugin for [Rouge] that adds support for [Lark]-style EBNF. It is based off of [rouge-plugin-example]. The EBNF lexer is modeled off of the [lexer for Augeas][aug].

[Lark]: https://github.com/lark-parser/lark
[Rouge]: https://github.com/rouge-ruby/rouge
[rouge-plugin-example]: https://github.com/rouge-ruby/rouge-plugin-example
[aug]: https://github.com/rouge-ruby/rouge/blob/3bba568ecf1c2d54132e65eb51ec16e745e8ec9d/lib/rouge/lexers/augeas.rb

To use this plugin (e.g. with your Jekyll-powered blog), add the following to your `Gemfile`:

```ruby
group :jekyll_plugins do
    gem 'rouge-ebnf', github: 'nchammas/rouge-ebnf', branch: 'master'
    # If you want to pin a specific commit, instead use:
    # gem 'rouge-ebnf', github: 'nchammas/rouge-ebnf', ref: 'commit-hash-goes-here'
end
```

## Why isn't this part of Rouge itself?

Rouge has an extreme policy [against LLM-generated code][contrib]. Even straightforward typo fixes are [rejected and redacted][typo] (yes, _redacted_) if they were created with an LLM. The EBNF lexer here was created with significant LLM assistance, so it needs to be a plugin.

[contrib]: https://github.com/rouge-ruby/rouge/blob/2a39d31735fb265b819c7370b35d5bc95c0ffaa8/Contributing.md
[typo]: https://github.com/rouge-ruby/rouge/issues/575#issuecomment-4489775939
