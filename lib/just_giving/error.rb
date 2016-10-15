module JustGiving
  class Error < StandardError; end

  class BadRequest < Error; end

  class Conflict < Error; end

  class NotFound < Error; end

  class InternalServerError < Error; end

  class InvalidApplicationId < Error; end

  class InvalidSecretKey < Error; end

  class Forbidden < Error; end

  class Unauthorized < Error; end
end
