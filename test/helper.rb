$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'test/unit'
require 'webmock/test_unit'
require 'shoulda'
require 'just_giving'

def stub_get(path, basic_auth=nil)
  stub_request(:get, make_url(path, basic_auth))
end

def stub_put(path, basic_auth=nil)
  stub_request(:put, make_url(path, basic_auth))
end

def stub_post(path, basic_auth=nil)
  stub_request(:post, make_url(path, basic_auth))
end

def stub_head(path)
  stub_request(:head, JustGiving::Configuration.api_endpoint + path)
end

def make_url(path, basic_auth)
  if basic_auth
    JustGiving::Configuration.api_endpoint.gsub('https://', "https://#{basic_auth}@") + path
  else
    JustGiving::Configuration.api_endpoint + path
  end
end

def fixture(file)
  File.new(File.expand_path("../fixtures", __FILE__) + '/' + file)
end

class Test::Unit::TestCase
end
