# ANSIEscape

This gem provides support for applying ANSI escape sequences to strings to format them for display in a terminal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ansi_escape'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ansi_escape

## Usage

Effects are defined in lib/ansi_escape/effects. Examples are shown below.

### Underline
~~~~
effect = ANSIEscape::Effects::Underline.new
effect.apply('foo bar baz')
 => "\e[4mfoo bar baz\e[24m" 
~~~~

### TextColor
~~~~
effect = ANSIEscape::Effects::TextColor.new(:red)
effect.apply('foo bar baz')
 => "\e[31mfoo bar baz\e[39m"
~~~~
Valid colors are `:black`, `:red`, `:green`, `:yellow`, `:blue`, `:magenta`, `:cyan`, and `:white`

### BackgroundColor
~~~~
effect = ANSIEscape::Effects::BackgroundColor.new(:red)
effect.apply('foo bar baz')
 => "\e[41mfoo bar baz\e[49m"
~~~~
Valid colors are `:black`, `:red`, `:green`, `:yellow`, `:blue`, `:magenta`, `:cyan`, and `:white`

### Composition
~~~~
underline = ANSIEscape::Effects::Underline.new
red_text = ANSIEscape::Effects::TextColor.new(:red)
green_background = ANSIEscape::Effects::BackgroundColor.new(:green)
effect = ANSIEscape::Effects::Composition.new(underline, red_text, green_background)
effect.apply('foo bar baz')
 => "\e[42m\e[31m\e[4mfoo bar baz\e[24m\e[39m\e[49m"
~~~~

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jimsong/ansi_escape.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
