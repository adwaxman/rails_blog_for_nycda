class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new

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

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end

end
