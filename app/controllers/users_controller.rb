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

    end

    def update

    end

    def search
      puts "*********************"
      puts params
      @user = User.find_by(fname: params[:query])
      if @user
        redirect_to user_path @user
      else
        flash[:alert] = "No user matched your search."
        redirect_to users_path
      end

    end


end
