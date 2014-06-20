HTTPFiesta
==========
Verify and assert your HTTParty responses with ease!

## Usage
Basic usage:
```ruby
response = HTTParty.get 'http://example.com'
response.assert.status(200).content_type('application/json')
```

More advanced:
```ruby
response = HTTParty.get 'http://example.com'
response.assert.status(200..299).content_type(:json)
```

## Installation

Add this line to your application's Gemfile:

    gem 'httpfiesta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install httpfiesta

## Contributing

1. Fork it ( https://github.com/cgthornt/httpfiesta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
