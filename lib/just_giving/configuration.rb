module JustGiving
  class Configuration
    API_ORIGINS = {
      :production => 'https://api.justgiving.com',
      :sandbox    => 'https://api.sandbox.justgiving.com'
    }

    BASE_URI_MAP = {
      :production => "https://www.justgiving.com",
      :sandbox    => "https://v3-sandbox.justgiving.com"
    }

    IDENTITY_ORIGINS = {
      :production => 'https://identity.justgiving.com',
      :sandbox    => 'https://identity.sandbox.justgiving.com'
    }

    @@application_id = nil
    @@secret_key = nil
    @@redirect_uri = nil
    @@environment = :sandbox
    @@ca_path =  "/usr/lib/ssl/certs"

    ## This is your Just Giving application id
    def self.application_id
      @@application_id
    end

    def self.application_id=(id)
      @@application_id = id
    end

    def self.secret_key
      raise JustGiving::InvalidSecretKey.new if !@@secret_key
      @@secret_key
    end

    def self.secret_key=(secret_key)
      @@secret_key = secret_key
    end

    def self.redirect_uri
      @@redirect_uri
    end

    def self.redirect_uri=(redirect_uri)
      @@redirect_uri = redirect_uri
    end


    def self.base_uri
      BASE_URI_MAP[self.environment]
    end

    ## This can be :sandbox, :staging or :production and sets what endpoint to use
    def self.environment=(env)
      @@environment = env
    end

    def self.environment
      @@environment
    end

    ## The API endpoint
    def self.api_endpoint
      raise JustGiving::InvalidApplicationId.new if !application_id
      API_ORIGINS.fetch(environment) + "/#{application_id}"
    end

    ## The Identity endpoint for OAuth
    def self.identity_endpoint
      raise JustGiving::InvalidApplicationId.new if !application_id
      IDENTITY_ORIGINS.fetch(environment)
    end

    ## Path to the systems CA cert bundles
    def self.ca_path=(path)
      @@ca_path = path
    end

    def self.ca_path
      @@ca_path
    end

    ## Username/password for basic auth
    def self.username
      @@username
    end

    def self.username=(username)
      @@username = username
    end

    def self.password=(password)
      @@password = password
    end

    def self.password
      @@password
    end
  end
end
