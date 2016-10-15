require 'faraday'
require 'multi_json'

module Faraday
  class Response::RaiseHttp4xx < Response::Middleware
    def on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 400
          raise JustGiving::BadRequest, error_message(response)
        when 401
          raise JustGiving::Unauthorized, error_message(response)
        when 403
          raise JustGiving::Forbidden, error_message(response)
        when 404
          raise JustGiving::NotFound, error_message(response)
        when 409
          raise JustGiving::Conflict, error_message(response)
        end
      end
    end

    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} #{error_body(response[:body])}"
    end

    def error_body(body)
      return nil if body.nil? || body.empty?
      body = MultiJson.decode(body)
      if body.nil?
        nil
      elsif body.is_a?(Hash) && body['error']
        "Error: #{body['error']}"
      elsif body.any?
        body.collect{|error| "#{error['id']} #{error['desc']}"}
      end
    rescue
      body.to_s
    end
  end
end
