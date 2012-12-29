class InfosController < ApplicationController

  def new
    @topic = Topic.find(params[:topic_id])
    @info = Info.new
    @info.images.build
  end


  def create
    current_topic = Topic.find(params[:topic_id])
    @info = current_topic.infos.build(params[:info])
 #  @info = current_topic.infos.images.build(params[:info])

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
      #flash[:success] = 'Info paragraph created!'
      #redirect_to topic_infos_path

     respond_to do |format|

        # format.html {
        #   render :json => [@info.to_jq_upload].to_json,
        #   :content_type => 'text/html',
        #   :layout => false
        # }

    #    format.json { render json: [@info.to_jq_upload].to_json, status: :created, location: @upload }
    #    format.json { render json: [@info.to_jq_upload].to_json, status: :created }
#        format.json { render json: [@info.to_jq_upload].to_json, status: :created }
     format.json { render json: [@info.to_jq_upload], status: :created }

        # too few args?
        #format.json { render :json => [@info.to_jq_upload], status: :created }
   #     format.json { render :json => [@info.to_jq_upload], status: :created }


      end
    else
      #render action: "new"
     render :json => [{:error => "custom_failure"}], :status => 304
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

    # If @info.child_of.nil? then the find above will behave with unpredictable results
    # So, we search for parental neighbors here:
    if @info.child_of.nil? then
      @infos = @topic.infos
      parents = @infos.reject{|i| !i.child_of.nil? }
      parents.sort_by!{ |x| x.relative_layout }
      parents.each{ |x| if x.relative_layout == prospective_layout then @neighbor = x end }
      end

    if (@neighbor != nil and
        @info.update_attributes(:relative_layout => prospective_layout) and
        @neighbor.update_attributes(:relative_layout => current_layout)
        )
      redirect_to topic_infos_path(@topic), notice: "Demotion succeeded. Moving:#{@info.id}"
    else
      redirect_to topic_infos_path(@topic), notice: "Demotion failed. Moving:#{@info.id}"
    end

  end


  def promote
    @topic = Topic.find(params[:topic_id])
    @info = Info.find(params[:id])

    current_layout = @info.relative_layout
    prospective_layout = current_layout - 1
    if prospective_layout < 0 then prospective_layout = 0 end

    is_child_of = @info.child_of

    @neighbor = Info.find_by_child_of_and_relative_layout(is_child_of,prospective_layout)

    # If @info.child_of.nil? then the find above will behave with unpredictable results
    # So, we search for parental neighbors here:
    if @info.child_of.nil? then
      @infos = @topic.infos
      parents = @infos.reject{|i| !i.child_of.nil? }
      parents.sort_by!{ |x| x.relative_layout }
      parents.each{ |x| if x.relative_layout == prospective_layout then @neighbor = x end }
      end

    if (@neighbor != nil and
        @info.update_attributes(:relative_layout => prospective_layout) and
        @neighbor.update_attributes(:relative_layout => current_layout)
        )
      redirect_to topic_infos_path(@topic), notice: "Promotion succeeded. Moving:#{@info.id}"
    else
      redirect_to topic_infos_path(@topic), notice: "Promotion failed. Moving:#{@info.id}"
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
    parents.each_with_index{ |p,px|
       if p.relative_layout != px then p.update_attributes(:relative_layout => px) end # repaired corruption from previous sorting regime
      @sorted_infos.push(p)
      children.each{ |c|
        if c.child_of == p.id then
          @sorted_infos.push(c)
      #    children.delete(c)
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
    if @info.child_of != nil then # If we have a non-parent node.
      @info.destroy
    else                          # If we have a parent node we must check for children.
      @infos = @topic.infos
      @sorted_infos = @infos.sort_by{ |a| [a.relative_layout] }
      @child_count = @sorted_infos.count{|x| x.child_of == @info.id }
      if @sorted_infos.count{|x| x.child_of == @info.id } > 0 then
        flash[:failure] = "Could not delete! This item has #{@child_count} subitem(s)"
      else
        @info.destroy
      end
    end
    redirect_to topic_infos_path(@topic)
  end




end
