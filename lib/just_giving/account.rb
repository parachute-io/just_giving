module JustGiving
  module Account
    def account
      request(:get, 'v1/account').tap do |account|
        @email = account['email']
      end
    end

    def email
      account unless @email
      @email
    end

    # This lists all the fundraising pages for the authorized email
    def account_pages
      request(:get, "v1/account/#{email}/pages")
    end

    # This creates a user account with Just Giving
    def create_account(params)
      request(:put, 'v1/account', params)
    end

    # This validates a username/password
    def validate_account(params)
      request(:post, 'v1/account/validate', params)
    end

    # Confirm if an email is available or not
    def account_available?(email)
      begin
        request(:head, "v1/account/#{email}")
        return false
      rescue JustGiving::NotFound
        return true
      end
    end

    # TODO: Not sure we want/need these
    #
    # # Update password
    # def change_password(params)
    #   post('v1/account/changePassword', params)
    # end

    # # Send password reminder
    # def password_reminder
    #   response = get("v1/account/#{@email}/requestpasswordreminder")
    #   (response && response[:errors]) ? response : true
    # end
  end
end
