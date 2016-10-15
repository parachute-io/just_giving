class Net::HTTP::ImmutableHeaderKey
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def downcase
    self
  end

  def capitalize
    self
  end

  def split(*)
    [self]
  end

  def hash
    key.hash
  end

  def to_s
    key
  end
end
