class InfosController < ApplicationController

  def new
     @topic = Topic.find(params[:topic_id])
     @info = Info.new
  end


  def create
    current_topic = Topic.find(params[:topic_id])
    @info = current_topic.infos.build(params[:info])

    @infos = current_topic.infos
    new_layout = 0

    if @info.child_of == nil then
      parents = []
      parents = @infos.reject{|i| !i.child_of.nil? }
      new_layout = parents.size
    else
      children = []
      children = @infos.reject{|i| i.child_of.nil? or i.child_of != @info.child_of }
      new_layout = children.size
    end

    @info.relative_layout = new_layout

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

    current_layout = @info.relative_layout
    prospective_layout = current_layout + 1
    is_child_of = @info.child_of

    @neighbor = Info.find_by_child_of_and_relative_layout(is_child_of,prospective_layout)

    if (@neighbor != nil and
        @info.update_attributes(:relative_layout => prospective_layout) and
        @neighbor.update_attributes(:relative_layout => current_layout)
        )
      redirect_to topic_infos_path(@topic), notice: 'demotion succeeded.'
    else
      redirect_to topic_infos_path(@topic), notice: 'demotion failed'
    end

    # new_relative_layout = @info.relative_layout + 1
    # if @info.update_attributes(:relative_layout => new_relative_layout)
    #   redirect_to topic_infos_path(@topic), notice: 'demotion succeeded'
    # else
    #   redirect_to topic_infos_path(@topic), notice: 'demotion failed'
    # end

  end


  def promote
    @topic = Topic.find(params[:topic_id])
    @info = Info.find(params[:id])

    current_layout = @info.relative_layout
    prospective_layout = current_layout - 1
    is_child_of = @info.child_of

    @neighbor = Info.find_by_child_of_and_relative_layout(is_child_of,prospective_layout)

    if (@neighbor != nil and
        @info.update_attributes(:relative_layout => prospective_layout) and
        @neighbor.update_attributes(:relative_layout => current_layout)
        )
      redirect_to topic_infos_path(@topic), notice: 'promotion succeeded.'
    else
      redirect_to topic_infos_path(@topic), notice: 'promotion failed'
    end

    # new_relative_layout = @info.relative_layout - 1
    # if @info.update_attributes(:relative_layout => new_relative_layout)
    #   redirect_to topic_infos_path(@topic), notice: 'promotion succeeded'
    # else
    #   redirect_to topic_infos_path(@topic), notice: 'promotion failed'
    # end

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
    parents.each_with_index{ |p,px|
      if p.relative_layout != px then p.update_attributes(:relative_layout => px) end # costly?
      @sorted_infos.push(p)
      children.each{ |c|
        if c.child_of == p.id then
          @sorted_infos.push(c)
          end
      }
    }
  end

  def show
  end

  def info
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @info = Info.find(params[:id])
    @infos = @topic.infos
    @sorted_infos = @infos.sort_by{ |a| [a.relative_layout] }
    @child_count = @sorted_infos.count{|x| x.child_of == @info.id }
    if
        @sorted_infos.count{|x| x.child_of == @info.id } > 0
    then
      #flash[:failure] = "Could not delete! #{@child_count} #{@info.id} #{@infos.each{|x| puts x.child_of }}"
      flash[:failure] = "Could not delete! #{@child_count} children to info id:#{@info.id} "
    else
      @info.destroy
    end
    redirect_to topic_infos_path(@topic)
  end








end
