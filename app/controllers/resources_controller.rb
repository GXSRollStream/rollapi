class ResourcesController < ApplicationController

  def search
    @resource = Resource.new(params[:resource])
    @resource.search

    render json: @resource.as_json(only: [:response_body, :response_code])
  end

  def index
  end
end
