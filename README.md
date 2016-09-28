just_giving
===========

A ruby wrapper for the justgiving.com API (https://api.justgiving.com/docs)

Installation
------------

```sh
gem install just_giving
```
    
Usage
-----

### Simple Donation Integration

Just giving provides 2 separate APIs - Simple Donation Integration (SDI) for making donations, and a JSON/XML API for querying and creating data.

This gem currently provides functionality to link to SDI, if you are using Rails you can use view helpers like so:

```erb
<%= link_to 'Click to donate', just_giving_charity_page_url('short_name') %>

<%= link_to 'Click to donate', just_giving_charity_donation_page_url('id', {
      :suggested_amount => 2..100000,
      :donation_id => 'JUSTGIVING-DONATION-ID',
      :amount => 2..100000, 
      :frequency => %w(single monthly),
      :exit_url => 'http://myredirect.com'
    }) %>
      
<%= link_to 'Click to donate', just_giving_fundraising_page_url('short_url') %>

<%= link_to 'Click to donate', just_giving_fundraising_donation_url('pageId' {
      :suggested_amount => 2..100000,
      :amount => 2..100000,
      :exit_url => 'http://myredirect.com', 
      :donation_id => 'JUSTGIVING-DONATION-ID'
    }) %>
```   
    
As you can see, `just_giving_charity_donation_page_url` and `just_giving_fundraising_donation_url` take an optional options hash - supply as many or as few of these as you need.

### API

#### Configure

```ruby
JustGiving::Configuration.application_id = YOUR_APP_ID # (required)
JustGiving::Configuration.ca_path = "/System/Library/OpenSSL/certs" # (defaults to "/usr/lib/ssl/certs")
JustGiving::Configuration.environment = :production (defaults to :staging)
JustGiving::Configuration.username = 'test@example.com' # Needed for actions that require auth
JustGiving::Configuration.password = 'secret' # Needed for actions that require auth
```

#### Account calls

```ruby
JustGiving::Account.new(YOUR_EMAIL).pages
```

```ruby
JustGiving::Account.new.create({
	:title => 'Mr',
	:firstName => 'Test',
	:lastName => 'McTest',
	:address => {
		:line1 => 'Unit 100', 
		:townOrCity => 'London', 
		:country => 'UK', 
		:postcodeOrZipcode => 'ec1r 0jh'
	},
	:email => 'test@example.com',
	:password => 'password',
	:acceptTermsAndConditions => true
})
```

#### Fundraising calls

```ruby
JustGiving::Fundraising.new('short-name').donations
```

For further examples please check the tests.

Note that a 404 will raise a `JustGiving::NotFound` error

A 400 response means the params supplied are wrong - this will return an errors collection with the details, eg:

```ruby
response = JustGiving::Account.new('unkown@unkown.com').password_reminder
response.errors # errors array
```

TODO
----

* Finish off all calls

Contributing to just_giving
---------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2011 Mint Digital. See LICENSE.txt for
further details.

