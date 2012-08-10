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
    self.response = begin
                      if request_type =='get'
                        make_rest.send(request_type)
                      else
                        make_rest.send(request_type, body)
                      end
                    rescue
                      $!.response
                    end
  end

  private

  def http_basic_auth
    { user: username, password: password }
  end

  def api_url
    "#{url}/api/v2000/#{current}?apiKey=apiKey"
  end

  def current
    if target.present?
      "#{resource}/#{target}.xml"
    else
      "#{resource}"
    end
  end

  def make_rest
    RestClient::Resource.new(api_url, http_basic_auth)
  end
end
