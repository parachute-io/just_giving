module JustGiving
  class Error < StandardError; end
  
  class NotFound < Error; end

  class InternalServerError < Error; end

  class InvalidApplicationId < Error; end

  class Forbidden < Error; end
end
