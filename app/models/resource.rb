class Resource < ActiveRecord::Base
  ATTRIBUTES = %w(api_key password  response api_key request_method request_id request_owner url user body)
  METHOD_MAPPING = { find: 'get', search: 'post', create: 'post', update: 'put' }

  store :response, accessors: [ :response_body, :response_code ]

  attr_accessible *(ATTRIBUTES - %w(response_body responde_code id))

  validates_presence_of *(ATTRIBUTES - %w(body response request_method))

  validate :request_method, presence: true, in: %w(find search create update)
  validate :request_id, if: :member_method?

  before_save :search
  before_validation :set_api_key, unless: :api_key

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

    parts.join('/')
  end

  private

    def http_basic_auth
      { user: user, password: password }
    end

    def set_api_key
      self.api_key ||= 'apiKey'
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
