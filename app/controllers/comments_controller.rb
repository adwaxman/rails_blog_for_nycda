class CommentsController < ApplicationController

  def new
    puts "#" * 30
    puts params
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    puts "$" * 30
    puts params
    body = params[:comment][:body]
    user_id = current_user.id
    post_id = params[:comment][:post_id]
    @comment = Comment.new(user_id: user_id, post_id: post_id, body: body)
    @post = Post.find(post_id)
    if @comment.save
      flash[:notice] = "Your comment was created successfully."
      redirect_to post_path @post
    else
      flash[:alert] = "There was a problem. Please try again"
      redirect_to post_path @post
    end

  end

end
