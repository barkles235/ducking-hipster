class InfosController < ApplicationController

  def new
     @topic = Topic.find(params[:topic_id])
     @info = Info.new
  end

  def create
    current_topic = Topic.find(params[:topic_id])
    @info = current_topic.infos.build(params[:info])
    if @info.save
      flash[:success] = 'Info paragraph created!'
      redirect_to topic_infos_path
    else
      render action: "new"
    end
  end

  def edit
  end

  def index
    @topic = Topic.find(params[:topic_id])
    @infos = @topic.infos

    # @parents = []
    # @parents_hash = Hash.new
    # @children = []

    # @infos.each{ |i|
    #   if(i.child_of.nil?) then
    #     @parents.push(i)
    #     @parents_hash[i] = Array.new
    #   else
    #     @children.push(i)
    #   end
    #   }

   # @top_infos = @infos.reject{|i| !(i.child_of.nil?)}


  end

  def show
  end

  def info
  end

  def destroy
  end
end
