class PostsController < ApplicationController

  before_action :user?

  def index
    @posts = Post.all
  end

  def new

  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = @post.comments
    @toplevels = get_top_level_comments(@post)
    @comment = Comment.new


  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    puts "********** PARAMS ****************"
    puts params
    puts "******** ID? *******"
    puts params[:post][:body]
    puts params[:id]

    post_id = params[:id]
    @post = Post.find(post_id)
    @user = @post.user
    body = params[:post][:body]
    @post.update(body: body)
    redirect_to user_path @user
    # redirect_to post_path post_id
  end

  def create
    puts "******************* PARAMS ********************"
    puts params
    body = params[:post][:body]
    id = current_user.id
    @post = Post.new(user_id: id, body: body)
    # @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Your post was created successfully."
      redirect_to user_path current_user
    else
      flash[:alert] = "There was a problem. Please try again"
      redirect_to user_path current_user
    end
  end

  def destroy
    puts "*" * 25
    puts params
    @post = Post.find(params[:id])
    @user = @post.user
    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to user_path @user
    else
      flash[:alert] = "There was a problem."
      redirect_to post_path @post
    end
  end

  def print_child_and_children(comment)
      puts comment.body
      children = comment.children
      children.each do |child|
        print_child_and_children(child)
      end
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end

  def print_child_and_children(comment)
      puts comment.body
      children = comment.children
      children.each do |child|
        print_child_and_children(child)
      end
  end

  def get_top_level_comments(post)
    Comment.where(post_id: post.id, parent_id: nil)
  end

  def user?
    unless current_user
      flash[:alert] = "You must be logged in."
      redirect_to root_path
    end
  end

end
