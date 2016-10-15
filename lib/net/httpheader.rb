require 'net/http'

module Net::HTTPHeader
  def capitalize(name)
    return name if name == 'x-application-key'
    name.capitalize
  end
  private :capitalize
end
