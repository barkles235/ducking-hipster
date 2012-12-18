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

    @parents = []
    @children = []

    @infos.each{ |i|
      if(i.child_of.nil?) then
        @parents.push(i)
      else
        @children.push(i)
      end
      }

    @sorted_infos = []
    # could sort parents by score here, prior to kids
    @parents.each{ |p|
      @sorted_infos.push(p)
      @children.each{ |c|
        if c.child_of == p.id then
          @sorted_infos.push(c)
          @children.delete(c)
          end
      }
    }


  end

  def show
  end

  def info
  end

  def destroy
  end
end
