require 'httpfiesta/unacceptable_response_error'

module HTTPFiesta
  class Assertion
    attr_reader :response

    CONTENT_TYPE_MAP = {
      json: 'application/json',
      xml: 'text/xml',
      html: 'text/html'
    }

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
      error "status code '#{response.code}' not in allowable range: #{description}"
    end

    alias_method :code, :status

    def content_type(type)
      raise ArgumentError, 'type cannot be nil' if type.nil?
      if type.is_a?(Symbol)
        if CONTENT_TYPE_MAP.key?(type)
          type = CONTENT_TYPE_MAP[type]
        else
          raise ArgumentError, "Unallowed content-type symbol :#{type}, valid symbols: #{CONTENT_TYPE_MAP.keys.join ', '}"
        end
      end
      raise ArgumentError, 'type must be a String or Symbol' unless type.is_a?(String)


      mime = response.headers['Content-Type']
      error 'Content-Type header not present' if mime.nil?
      if mime.downcase.include?(type.to_s)
        self
      else
        error "response content type '#{mime}' does not match expected type of '#{type}'"
      end
    end
    alias_method :content, :content_type

    protected

    def error(message)
      raise UnacceptableResponseError.new(message, response)
    end
  end
end
