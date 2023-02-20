# PIDCache

Cache calls to `Process.pid` to avoid lots of useless system calls on modern Linux.

Ruby's `Process.pid` calls the standard `libc` `getpid(2)`, historically pretty much all
implementations of the `libc` have been caching this function to avoid doing a syscall everytime.

However `glibc 2.25` released in 2017 removed that cache, causing a performance regression for application
frequently monitoring the PID.

The reason they removed it, is that some low-level libraries would `fork` by calling the syscall themselves,
bypassing the code responsible for clearing the cache.

But doing this in Ruby is impossible, so we can safely cache the PID and save some performance.

This gem is a backport of [a proposed feature for Ruby 3.3](https://bugs.ruby-lang.org/issues/19443), hopefully
as of Ruby 3.3 this gem may be useless.

## Requirements

This gem only work on Ruby 3.1+, on older rubies it has no effect.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add pid_cache

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install pid_cache

## Usage

That's it, the cache is applied immediately uppon requiring the gem, and is automatically flushed upon fork.

Note that the caching only applies to `Process.pid`, the `$$` magic variable is unimpacted.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Shopify/pid_cache.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
