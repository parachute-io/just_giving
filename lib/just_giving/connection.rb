require 'faraday_middleware'
require 'faraday/raise_http_4xx'
require 'faraday/raise_http_5xx'

module JustGiving
  module Connection
    attr_accessor :access_token

    private

    def connection(basic_auth=false)
      options = {
        :headers => {
          Net::HTTP::ImmutableHeaderKey.new("x-application-key") => JustGiving::Configuration.secret_key,
          'Accept' => "application/json"
        },
        :url => JustGiving::Configuration.api_endpoint,
        :ssl => {:ca_path => JustGiving::Configuration.ca_path, :verify => false}
      }

      connection = Faraday::Connection.new(options) do |connection|
        connection.authorization(:Bearer, access_token) unless access_token.nil?
        connection.request :json

        connection.response :json
        connection.response :mashify

        connection.use Faraday::Response::RaiseHttp4xx
        connection.use Faraday::Response::RaiseHttp5xx

        connection.adapter :net_http
      end
      connection.basic_auth(JustGiving::Configuration.username, JustGiving::Configuration.password) if basic_auth
      connection
    end
  end
end
