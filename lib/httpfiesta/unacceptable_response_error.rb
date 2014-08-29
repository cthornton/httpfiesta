module HTTPFiesta
  class UnacceptableResponseError < StandardError
    attr_reader :response

    def initialize(message, response)
      super(message)
      @response = response
    end

    def to_s
      request_method = response.request.http_method.to_s.split('::').last.upcase rescue ''
      "HTTP #{request_method} #{response.request.path} : #{super}"
    end
  end
end
