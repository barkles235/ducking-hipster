class TopicsController < ApplicationController

  def index
    @topics = Topic.paginate(page: params[:page])
  end

  def show
    @topic = Topic.find(params[:id])
    @topics = Topic.paginate(page: params[:page])
 end

  def info
    @topic = Topic.find(params[:id])
    @infos = @topic.infos.paginate(page: params[:page])
    @info = @topic.infos.build
  end

end
