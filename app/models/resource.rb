class Resource
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :url, :response, :request_type, :target, :resource, :apiKey, :body, :username, :password
  validates_presence_of  :url, :resource, :apiKey, :body, :username, :password


  def persisted?
    false
  end
  def initialize(attrs={})
    attrs.each do | key, value |
      send("#{key}=", value)
    end
  end

  def search
    begin
    self.response = make_rest.send(request_type)
    rescue
      self.response = $!.response
    end
  end

  def http_basic_auth
    { user: username, password: password }
  end

  def api_url
    "#{url}/api/v2000/#{current}?apiKey=apiKey"
  end

  def current
    "#{resource}/#{target}.xml"
  end

  def make_rest
    RestClient::Resource.new(api_url, http_basic_auth)
  end
end
