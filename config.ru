require 'rouge'

Rouge::Lexer.enable_debug!

run do |env|
  Object.send(:remove_const, :RougeEBNF) if defined?(::RougeEBNF)
  $LOADED_FEATURES.reject! { |f| f.start_with?(File.expand_path(__dir__)) }
  require_relative 'lib/rouge-ebnf'

  input = File.read(ENV["SAMPLE_FILE"] || "#{__dir__}/spec/sample.ebnf")
  lexer = Rouge::Lexer.find_fancy("ebnf?#{env['QUERY_STRING']}")
  formatter = Rouge::Formatters::HTML.new
  highlighted = formatter.format(lexer.lex(input))
  theme_css = Rouge::Themes::Github.render(scope: '.highlight')

  body = <<~HTML
    <!doctype html>
    <html>
      <head><style>#{theme_css}</style></head>
      <body><div class="highlight"><pre>#{highlighted}</pre></div></body>
    </html>
  HTML

  [200, { 'content-type' => 'text/html' }, [body]]
end
