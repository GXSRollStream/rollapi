class Resource
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  ATTRIBUTES = %w(response_body response_code password  response api_key request_method request_id request_owner url user body)

  METHOD_MAPPING = { find: 'get', search: 'post', create: 'post', update: 'put' }

  attr_accessor *ATTRIBUTES

  validate :request_id, if: :member_method?

  def persisted?
    false
  end

  def initialize(attrs={})
    attrs.each do | key, value |
      send("#{key}=", value)
    end

    self.api_key ||= 'apiKey'
  end

  def search
    self.response_body, self.response_code = call
  end

  def api_method
    METHOD_MAPPING[request_method.try(:to_sym)]
  end

  def member_method?
    %w(find update).include?(request_method)
  end

  def api_url
    parts = [ url, 'api', 'v2000', request_owner ]

    if member_method?
      parts << request_id
    end

    parts << 'search' if search?

    parts.join('/')
  end

  private
    def search?
      request_method == 'search'
    end

    def http_basic_auth
      { user: user, password: password }
    end

    def call
      args = [ api_method ]
      args << body unless api_method == 'get' 

      begin
        [ client.send(*args), 200 ]
      rescue Exception => e 
        if e.respond_to?(:http_body)
          [ e.http_body, e.http_code ]
        else
          [ e.message, 500 ]
        end
      end
    end

    def client
      RestClient::Resource.new("#{api_url}?apiKey=#{api_key}", http_basic_auth)
    end
end
