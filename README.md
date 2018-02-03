# IpConverter

[![Build Status](https://travis-ci.org/joshuawscott/ipconverter.svg?branch=master)](https://travis-ci.org/joshuawscott/ipconverter)

Library to deal with IP Address conversions/manipulation, such as converting
a string representation like "192.168.2.1" to its integer representation
(3232236033)

Tested with Ruby >= 1.9.3.

## Installation

Add this line to your application's Gemfile:

    gem 'ipconverter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ipconverter

## Usage

```
require 'ipconverter'
IpConverter.str_to_int "192.168.2.1"
 => 3232236033
```
str_to_int raises an error if the address is not valid:
```
IpConverter.str_to_int "192.168.2"
 => raises ArgumentError
```

## Running the tests

Clone the repo
```
bundle install
bundle exec rake compile
bundle exec rake test
```

## Contributing

1. Fork it ( https://github.com/joshuawscott/ipconverter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
