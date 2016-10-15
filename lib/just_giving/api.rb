require 'just_giving/connection'
require 'just_giving/request'

module JustGiving
  class API
    include Connection
    include Request

    def request(verb, url, params)
      connection.run_request(verb, url, params, {})
    end
  end
end
