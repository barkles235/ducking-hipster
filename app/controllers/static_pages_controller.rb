class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
     # @feed_items = current_user.feed.paginate(page: params[:page])
     # @feed_items = current_user.feed

      @feed_items = []
      # @feed_items = Post.where("user_id = ?", 2)
      @feed_items = Post.where("user_id = ?", 2).paginate(page: params[:page])

   end
  end

  def help
  end

  def about
  end

  def contact
  end
end
