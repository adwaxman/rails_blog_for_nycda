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
    parent_id = params[:comment][:parent_id]
    @comment = Comment.new(user_id: user_id, post_id: post_id, body: body, parent_id: parent_id)
    @post = Post.find(post_id)
    if @comment.save
      flash[:notice] = "Your comment was created successfully."
      redirect_to post_path @post
    else
      flash[:alert] = "There was a problem. Please try again"
      redirect_to post_path @post
    end

  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment_id = params[:id]
    @comment = Comment.find(comment_id)
    @post = @comment.post
    body = params[:comment][:body]
    @comment.update(body: body)
    redirect_to post_path @post

  end

  def destroy
    puts "$" * 35
    puts params
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.destroy
      flash[:notice] = "Your comment has been deleted."
      redirect_to post_path @post
    else
      flash[:alert] = "There was a problem"
      redirect_to post_path @post
    end
  end

end
