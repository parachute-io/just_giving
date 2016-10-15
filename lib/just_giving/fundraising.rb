module JustGiving
  module Fundraising
    # def initialize(short_name=nil)
    #   @short_name = short_name
    # end

    # Get all pages
    def fundraising_pages
      request(:get, "v1/fundraising/pages")
    end

    # Create a new fundraising page
    def create_fundraising_page(params)
      # put("v1/fundraising/pages", {:basic_auth => true}.merge(params))
      request(:put, "v1/fundraising/pages", params)
    end

    # Check if a short name is registered
    def fundraising_short_name_registered?(short_name)
      begin
        request(:head, "v1/fundraising/pages/#{short_name}")
        return true
      rescue JustGiving::NotFound
        return false
      end
    end

    # Get a specific page
    def fundraising_page(short_name)
      request(:get, "v1/fundraising/pages/#{short_name}")
    end

    # Get all donations per page
    def donations(page=1, per_page=50, auth = false)
      get("v1/fundraising/pages/#{@short_name}/donations?pageNum=#{page}&pagesize=#{per_page}",
        :basic_auth => auth)
    end

    # Update a pages story
    def update_fundraising_page_story(short_name, story)
      # request(:post, "v1/fundraising/pages/#{short_name}", {:storySupplement => story})
      request(:put, "v1/fundraising/pages/#{short_name}/pagestory", { story: story })
    end

    def upload_fundraising_page_image(short_name, image_url)
      request(:put, "v1/fundraising/pages/#{short_name}/images", {
        url: image_url
      })
    end

    def set_fundraising_page_default_image(short_name, image_name)
      request(:put, "v1/fundraising/pages/#{short_name}/images/default", {
        defaultImage: image_name
      })
    end

    def suggest
      # TODO
    end
  end
end
