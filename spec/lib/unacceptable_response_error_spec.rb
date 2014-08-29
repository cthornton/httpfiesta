require 'helper'


describe HTTPFiesta::UnacceptableResponseError do
  let(:status_code)  { 404 }
  let(:content_type) { 'application/json' }
  let(:return_body)  { { 'error' => 'foobar'}.to_json }

  let(:response)     { HTTParty.get 'http://example.com' }
  before do
    stub_request(:any, 'http://example.com').
      to_return(body: return_body, status: status_code, headers: { content_type: content_type })
  end



  describe '#to_s' do
    it 'returns a correct message' do
      begin
        response.assert.status(200)
      rescue HTTPFiesta::UnacceptableResponseError => e
        expect(e.message).to eq('HTTP GET http://example.com : status code \'404\' not in allowable range: 200..200')
      end
    end
  end

end
