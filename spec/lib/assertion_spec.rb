require 'helper'

describe HTTPFiesta::Assertion do
  let(:status_code)  { 200 }
  let(:content_type) { 'application/json' }
  let(:return_body)  { { 'hello' => 'world'}.to_json }

  let(:response)     { HTTParty.get 'http://example.com' }
  before do
    stub_request(:any, 'http://example.com').
      to_return(body: return_body, status: status_code, headers: { content_type: content_type })
  end


  describe '#status' do
    context 'with only a single acceptable range' do
      it 'allows acceptable status code' do
        expect {
          response.assert.status(200)
        }.to_not raise_error
      end

      it 'allows an acceptable status code within a range' do
        expect {
          response.assert.status(150..300)
        }.to_not raise_error
      end

      it 'does not permit unacceptable status codes' do
        expect {
          response.assert.status(201)
        }.to raise_error(HTTPFiesta::UnacceptableResponseError)
      end

      it 'does not permit unacceptable status codes that are not within a range' do
        expect {
          response.assert.status(300..400)
        }.to raise_error(HTTPFiesta::UnacceptableResponseError)
      end
    end

    context 'with several acceptable ranges' do
      it 'allows the response if it is within one of multiple ranges' do
        expect {
          response.assert.status(100..110, 190..200, 300..400)
        }.to_not raise_error
      end

      it 'denies the response if it is *not* within one of multiple ranges' do
        expect {
          response.assert.status(100..110, 190..199, 201..220, 300..400)
        }.to raise_error(HTTPFiesta::UnacceptableResponseError)
      end
    end

    context 'return object' do
      it 'always returns itself (if successful)' do
        assertion = response.assert
        expect(assertion.status(200)).to eq(assertion)
      end
    end
  end

  describe '#content_type' do
    it 'allows valid content types' do
      expect {
        response.assert.content_type('application/json')
      }.to_not raise_error
    end

    it 'accepts a symbol shortcut' do
      expect {
        response.assert.content_type(:json)
      }.to_not raise_error
    end

    it 'denies an invalid content type' do
      expect {
        response.assert.content_type('text/xml')
      }.to raise_error(HTTPFiesta::UnacceptableResponseError)
    end

    it 'always returns itself' do
      assertion = response.assert
      expect(assertion.content_type(:json)).to eq(assertion)
    end

    it 'raises an ArgumentError if it is given garbage input' do
      expect {
        response.assert.content_type(:asdf)
      }.to raise_error(ArgumentError)
    end
  end
end
