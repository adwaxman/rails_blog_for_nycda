class UsersController < ApplicationController

    before_action :user?, except: [:new, :create]

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @post = Post.new
      @posts = Post.where(user_id: params[:id]).reverse

    end

    def new
      @user = User.new
    end

    def create
      puts "******PARARMS"
      puts params
      @user = User.new(user_params)
        if @user.save
          flash[:notice] = "Your account has been created successfully!"
          session[:user_id] = @user.id
          redirect_to user_path @user
        else
          flash[:alert] = "There was a problem. Please try again."
          redirect_to users_new_path
        end

    end

    def edit
      if current_user
        @user = current_user
      else
        flash[:alert] = "You must be logged in to view your profile"
        redirect_to login_path
      end
    end

    def update

      puts '*********************************'
      puts params
      @user = current_user
      puts '************* @user ************'
      puts @user.inspect
      @user.update(user_params)
      flash[:notice] = "Your profile was updated"
      redirect_to user_path @user
    end

    def search
      puts "*********************"
      puts params
      # @user = User.find_by(fname: params[:query])
      # if @user
      #   redirect_to user_path @user
      # else
      #   flash[:alert] = "No user matched your search."
      #   redirect_to users_path
      # end

      search_results = User.where(fname: params[:query])
      puts "*********************** @users"
      puts search_results
      if search_results.length == 0
        flash[:alert] = "No user matched your search."
        redirect_to users_path
      elsif search_results.length == 1
        redirect_to user_path search_results.first
      else
        @users = search_results
        flash[:notice] = "Multiple users matched your search"
      end

    end

    def results

    end

    def destroy
      @user = current_user
      if @user.destroy
        flash[:notice] = "Account was successfully deleted."
      else
        flash[:alert] = "There was a problem"
        redirect_to users_edit_path
      end
      session[:user_id] = nil
      redirect_to root_path
    end

    private

    def user_params
      params.require(:user).permit(:fname, :lname, :email, :password)
    end

    def user?
      unless current_user
        flash[:alert] = "You must be logged in."
        redirect_to root_path
      end
    end

end
