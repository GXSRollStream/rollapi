class ResourcesController < ApplicationController
  def index
    @resource = Resource.new({
      url: 'http://localhost:3000',
      apiKey: 'apiKey',
      username: 'apiKey',
      password: 'password',
      resource: 'contact'
    })
  end

  def create
    @resource = Resource.new(params[:resource])
    @resource.search
    render :index
  end
end
