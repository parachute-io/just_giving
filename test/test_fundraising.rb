require 'helper'

class TestFundraising < Minitest::Test
  def setup
    JustGiving::Configuration.application_id = '2345'
    JustGiving::Configuration.secret_key = 'abcd'
  end

  context 'using OAuth' do
    should 'get pages' do
      stub_get('/v1/fundraising/pages').to_return(
        :body    => fixture('fundraising_pages_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'}
      )

      pages = client.fundraising_pages
      assert_equal 2, pages.count
      assert_equal 'Test 72', pages[1]['pageTitle']
    end

    should 'get donations' do
      stub_get('/v1/fundraising/pages/test/donations?pageNum=1&pagesize=50').to_return(
        :body    => fixture('fundraising_donations_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'}
      )

      pages = client.donations('test', 1, 50)
    end

    should 'set pagination options for donations' do
      stub_get('/v1/fundraising/pages/test/donations?pageNum=2&pagesize=10').to_return(
        :body    => fixture('fundraising_donations_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'}
      )

      pages = client.donations('test', 2, 10)
    end

    should 'create page' do
      stub_put('/v1/fundraising/pages').to_return(
        :body    => fixture('fundraising_pages_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'},
        :status  => 201
      )

      # page = JustGiving::Fundraising.new.create({})
      page = client.create_fundraising_page({})

    end

    should 'raise exception if create page fails' do
      stub_put('/v1/fundraising/pages').to_return(
        :body    => fixture('fundraising_page_create_failure.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'},
        :status  => 409
      )

      # page = JustGiving::Fundraising.new.create({})
      assert_raises JustGiving::Conflict do
        page = client.create_fundraising_page({})
      end
    end

    should 'update story' do
      stub_put('/v1/fundraising/pages/test/pagestory').with(
        :body       => '{"story":"new story"}'
      ).to_return(
        :body => fixture('fundraising_update_story_success.json'),
        :headers => {:content_type => 'application/json; charset=utf-8'},
        :status => 200
      )

      # page = JustGiving::Fundraising.new('test').update_story('new story')
      page = client.update_fundraising_page_story('test', 'new story')
    end
  end

  context 'with no basic auth' do
    should 'check if short name is registered' do
      stub_head('/v1/fundraising/pages/test').to_return(
        :status  => 200,
        :headers => { :content_type => 'application/json; charset=utf-8'},
        :body    => "{}"
      )

      assert client.fundraising_short_name_registered? 'test'
    end

    should 'check if short name is registered when not found' do
      stub_head('/v1/fundraising/pages/test').to_return(
        :status  => 404,
        :headers => {:content_type => 'application/json; charset=utf-8'}
      )

      refute client.fundraising_short_name_registered? 'test'
    end

    should 'get fundraising page' do
      stub_get('/v1/fundraising/pages/test').to_return(
        :body    => fixture('fundraising_get_page_success.json'),
        :status  => 200,
        :headers => {:content_type =>  'application/json; charset=utf-8'}
      )

      # page = JustGiving::Fundraising.new('test').page
      page = client.fundraising_page('test')
      assert_equal "00A246", page["branding"]["buttonColour"]
      assert_equal "261017", page["charity"]["registrationNumber"]
    end
  end
end
