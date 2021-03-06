require 'spec_helper'

describe 'Yt::Auth.url_for' do
  context 'given a valid redirect URI' do
    url = Yt::Auth.url_for redirect_uri: 'http://example.com'

    it 'returns a link to Google authentication flow' do
      expect(url).to start_with 'https://accounts.google.com/o/oauth2/auth'
    end

    it 'includes the redirect URI' do
      escaped_uri = CGI.escape('http://example.com')
      expect(url).to include "redirect_uri=#{escaped_uri}"
    end

    it 'includes the client ID' do
      expect(url).to include "client_id=#{Yt.configuration.client_id}"
    end
  end
end
