require 'oauth2'
require 'base64'
require 'securerandom'

module JustGiving
  class Client
    attr_accessor :token, :oauth_client

    def initialize(token)
      @token = token
    end

    def request(verb, path, params = {})
      refresh_oauth_access_token! if oauth_access_token.expired?

      api = API.new
      api.access_token = oauth_access_token.token
      response = api.request(verb, api_url_for(path), params)

      response.body
    end

    def self.authorization_url
      oauth_client.auth_code.authorize_url({
        redirect_uri: self.redirect_uri,
        scope: 'openid profile email account fundraise offline_access',
        nonce: SecureRandom.uuid
      })
    end

    def self.from_authorization_code(auth_code)
      token = oauth_client.auth_code.get_token(auth_code, {
        redirect_uri: self.redirect_uri
      })

      return new(token.to_hash)
    end

    private

    def api_url_for(path)
      _path = '/' + path.gsub(/^\//, '') # ensure leading slash
      JustGiving::Configuration.api_endpoint + _path
    end

    def oauth_access_token
      @oauth_access_token ||= OAuth2::AccessToken.from_hash(oauth_client, token)
    end

    def oauth_client
      @oauth_client ||= self.class.oauth_client
    end

    def refresh_oauth_access_token!
      @token = oauth_access_token.refresh!({
        redirect_uri: self.class.redirect_uri
      }).to_hash
      @oauth_access_token = nil
    end

    def self.oauth_client
      client_id = JustGiving::Configuration.application_id
      secret    = JustGiving::Configuration.secret_key

      OAuth2::Client.new(client_id, secret, {
        site: JustGiving::Configuration.identity_endpoint,
        authorize_url: '/connect/authorize',
        token_url: '/connect/token',
        connection_opts: {
          headers: {
            Net::HTTP::ImmutableHeaderKey.new("x-application-key") => secret,
          }
        }
      }) do |connection|
        connection.request :basic_auth, client_id, secret
        connection.request :url_encoded
        connection.use Faraday::Response::RaiseHttp4xx
        connection.adapter :net_http
      end
    end

    def self.redirect_uri
      JustGiving::Configuration.redirect_uri
    end
  end
end
