module JustGiving
  class Countries < API
    # Get charity by id
    def get_countries
      get("v1/countries")
    end
  end
end