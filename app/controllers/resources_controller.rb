class ResourcesController < ApplicationController
  def create
    render json: Resource.create(params[:resource]) 
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
