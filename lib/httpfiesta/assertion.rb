require 'httpfiesta/unacceptable_response_error'

module HTTPFiesta
  class Assertion
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def status(*ranges_or_codes)
      ranges = ranges_or_codes.map do |range_or_code|
        range = range_or_code.is_a?(Range) ? range_or_code : range_or_code..range_or_code
        return self if range.include?(response.code.to_i)
        range
      end

      # If we're here, then error
      description = ranges.map(&:to_s).join(', ')
      error "status code '#{code}' not in allowable range: #{description}"
    end

    def content_type(type)
      mime = response.headers['Content-Type']
      error 'Content-Type header not present' if mime.nil?
      if mime.downcase.include?(type)
        self
      else
        error "response content type '#{mime}' does not"
      end
    end

    protected

    def error(message)
      raise UnacceptableResponseError.new(message, response)
    end
  end
end
