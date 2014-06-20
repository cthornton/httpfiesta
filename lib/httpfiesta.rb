require 'httpfiesta/version'
require 'httpfiesta/assertion'

module HTTPFiesta
end

# Monkey-patching!
if defined? HTTParty::Response
  class HTTParty::Response
    def assert
      ::HTTPFiesta::Assertion.new(self)
    end
  end
end
