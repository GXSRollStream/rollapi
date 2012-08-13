class ResourcesController < ApplicationController
  def search
    @resource = Resource.new(params[:resource])
    @resource.search

    render json: @resource
  end

  def index
  end
end
