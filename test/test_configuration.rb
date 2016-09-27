require 'helper'

class TestConfiguration < Minitest::Test
  def config
    JustGiving::Configuration
  end

  should 'allow setting/getting of application_id' do
    config.application_id = '1234'
    assert_equal '1234', config.application_id

    config.application_id = '5678'
    assert_equal '5678', config.application_id
  end

  should 'allow setting the enviroment' do
    config.environment = :staging
    assert_equal :staging, config.environment

    config.environment = :sandbox
    assert_equal :sandbox, config.environment

    config.environment = :production
    assert_equal :production, config.environment
  end

  should 'return the base_uri based on environment' do
    config::BASE_URI_MAP.each do |k,v|
      config.environment = k
      assert_equal v, config.base_uri
    end
  end

  should 'return the api endpoint' do
    config.application_id = '5678'
    config.environment = :sandbox
    assert_equal 'https://api-sandbox.justgiving.com/5678', config.api_endpoint

    config.environment = :staging
    assert_equal 'https://api-staging.justgiving.com/5678', config.api_endpoint

    config.environment = :production
    assert_equal 'https://api.justgiving.com/5678', config.api_endpoint
  end

  should 'raise if application id is not set' do
    config.application_id = nil
    assert_raises JustGiving::InvalidApplicationId do
      config.api_endpoint
    end
  end

  should 'return the ca_path' do
    assert_equal '/usr/lib/ssl/certs', config.ca_path
    config.ca_path = '/System/Library/OpenSSL/certs'
    assert_equal '/System/Library/OpenSSL/certs', config.ca_path
  end
end
