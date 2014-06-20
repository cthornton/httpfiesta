require 'helper'

describe HTTParty::Response do
  before do
    stub_request(:any, 'http://example.com').to_return(body: 'hello world')
  end

  describe '#assert' do
    it 'should be monkeypatched correctly' do
      response =  HTTParty.get 'http://example.com'
      expect(response.assert).to be_a(HTTPFiesta::Assertion)
      expect(response.assert.response).to eq(response)
    end
  end
end
