module HTTPFiesta
  class UnacceptableResponseError < StandardError
    attr_reader :response

    def initialize(message, response)
      super(message)
      @response = response
    end

    def message
      "HTTP #{response.request.method.upcase} #{response.request.path} : #{super}"
    end
  end
end
