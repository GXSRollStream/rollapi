class ResourcesController < ApplicationController
  def search
    @resource = Resource.new(params[:resource])
    @resource.search
    render json: @resource
  end

  def update
    @resource = Resource.find(params[:id])
    args = params[:resource].except(:response_code, :response_body, :id)
    @resource.update_attributes(args)
    render json: @resource
  end

  def index
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: Resource.all }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: { resource: Resource.find(params[:id]) } }
    end
  end
end
