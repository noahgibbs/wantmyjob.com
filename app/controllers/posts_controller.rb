class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :requires_admin, :except => [:index, :show]

  respond_to :html

  expose(:posts) { Post.all }
  expose(:post)

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post, :notice => 'Post was successfully created.')
    else
      render :action => 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render :action => 'edit'
    end
  end

  def destroy
    post.destroy

    redirect_to posts_url
  end
end
