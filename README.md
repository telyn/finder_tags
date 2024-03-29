# FinderTags

Library and utilities for dealing with tags from Finder.
It should run on any OS where xattrs are supported - but you'll only see tags on macOS I'd wager.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'finder_tags'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install finder_tags

## Usage

```ruby
require "finder_tags"

FinderTags.new("path/to/file").tags
# => [#<struct FinderTags::Tag name="Cool Tag", color=:blue>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/telyn/finder_tags.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
