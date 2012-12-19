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

  def demote
    @topic = Topic.find(params[:topic_id])
    @info = Info.find(params[:id])
    new_relative_layout = @info.relative_layout + 1
    if @info.update_attributes(:relative_layout => new_relative_layout)
      redirect_to topic_infos_path(@topic), notice: 'demotion successfully updated.'
    else
      redirect_to topic_infos_path(@topic), notice: 'demotion failed'
    end
  end

  def promote
    @topic = Topic.find(params[:topic_id])
    @info = Info.find(params[:id])
    new_relative_layout = @info.relative_layout - 1
    if @info.update_attributes(:relative_layout => new_relative_layout)
      redirect_to topic_infos_path(@topic), notice: 'demotion successfully updated.'
    else
      redirect_to topic_infos_path(@topic), notice: 'demotion failed'
    end
  end


  def index
    @topic = Topic.find(params[:topic_id])
    @infos = @topic.infos

    parents = []
    children = []

    @infos.each{ |i|
      if(i.child_of.nil?) then
        parents.push(i)
      else
        children.push(i)
      end
      }

    parents.sort_by!{|a| [a.relative_layout]}
    children.sort_by!{|a| [a.child_of,a.relative_layout] }

    @sorted_infos = []
    parents.each{ |p|
      @sorted_infos.push(p)
      children.each{ |c|
        if c.child_of == p.id then
          @sorted_infos.push(c)
          ###children.delete(c)
          end
      }
    }

###############

    # parents = @infos.reject{|i| !i.child_of.nil? }
    # children = @infos.reject{|i| i.child_of.nil? }
    # parents_hash = Hash.new([])
    # parents.each{|p| parents_hash[p.id] << p }
    # children.each{|c| parents_hash[c.child_of] << c }
    # @sorted_infos = []
    # parents_hash.each{|k,a| a.each{ |inf| @sorted_infos << inf }}

    # @sorted_infos = @infos.sort{ |a,b| n.id }


  end

  def show
  end

  def info
  end

  def destroy
  end
end
