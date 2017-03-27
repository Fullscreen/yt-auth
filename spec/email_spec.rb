require 'spec_helper'

describe 'Yt::Auth#email' do
  context 'not given any authorization code' do
    missing = 'Missing required parameter: code'

    it 'raises an error (missing code)' do
      auth = Yt::Auth.new
      expect{auth.email}.to raise_error Yt::AuthError, missing
    end
  end

  context 'given an invalid authorization code' do
    invalid = 'Invalid authorization code.'

    it 'raises an error (invalid or already redeemed)' do
      auth = Yt::Auth.new code: rand(36**20).to_s(36)
      expect{auth.email}.to raise_error Yt::AuthError, invalid
    end
  end

  context 'given a valid authorization code' do
    email = 'user@example.com'
    auth = Yt::Auth.new code: 'valid'

    it 'returns a valid email' do
      expect(auth.email).to eq email
    end

    # NOTE: This test needs to be mocked because getting a real authorization
    # code requires a web interaction from a real user.
    before do
      expect(auth).to receive(:tokens).and_return 'access_token' => '1234'
      response = double 'response'
      expect_any_instance_of(Yt::AuthRequest).to receive(:run) { response }
      expect(response).to receive(:body).and_return 'email' => email
    end
  end
end