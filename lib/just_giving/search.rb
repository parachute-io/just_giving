module JustGiving
  class Search < API
    # Search charites
    def search_charities(query, page=1, per_page=10)
      get("v1/charity/search?q=#{query}&page=#{page}&pageSize=#{per_page}")
    end

    # Search events
    def search_events(query, page=1, per_page=10)
      get("v1/event/search?q=#{query}&page=#{page}&pageSize=#{per_page}")
    end

    # Search fundraising
    def search_fundraising(query, charity_id=nil, cause_id=nil, event_id=nil, design_id=nil, status=nil, event_date_range=nil, page=1, per_page=10)
      get("v1/fundraising/search?q=#{query}&=page=#{page}&pagesize=#{per_page}&causeid=#{cause_id}&eventid=#{event_id}&charityid=#{charity_id}&designid=#{design_id}&status=#{status}&eventdaterange=#{event_date_range}")
    end
  end
end
