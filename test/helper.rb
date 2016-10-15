$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'just_giving'
require 'webmock/minitest'
require 'shoulda'
require 'minitest/autorun'

def stub_get(path)
  stub_request(:get, make_url(path))
end

def stub_put(path)
  stub_request(:put, make_url(path))
end

def stub_post(path)
  stub_request(:post, make_url(path))
end

def stub_head(path)
  stub_request(:head, make_url(path))
end

def make_url(path)
  JustGiving::Configuration.api_endpoint + path
end

def fixture(file)
  File.new(File.expand_path("../fixtures", __FILE__) + '/' + file)
end

def client
  JustGiving::Client.new(token)
end

def token
  JSON.parse(fixture('oauth_access_token.json').read)
end
