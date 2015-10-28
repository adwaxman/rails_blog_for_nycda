class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])

    end

    def new
      @user = User.new
    end

    def create
      puts "******PARARMS"
      puts params
      @user = User.new(params[:user])
        if @user.save
          flash[:notice] = "Your account has been created successfully!"
          redirect_to users_path
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
        redirect_to user_path @users.first
      else
        @users = search_results
        flash[:notice] = "Multiple users matched your search"
      end

    end

    def results

    end





end
