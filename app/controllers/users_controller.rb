class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
    before_action :authenticate_user!, only: %i[show edit update]
  
    def index
      redirect_to signup_url
    end
  
    def show
      @opinions = Opinion.ordered_opinion.include_user_copied.user_filter_Opinion(@user)
      @users = @user.followds
      @users2 = @user.follows
    end
  
    def new
      @user = User.new
    end
  
    def edit
      redirect_to edit_user_path(current_user) unless current_user == @user
    end
  
    def create
      @user = User.new(user_params)
  
      respond_to do |format|
        if @user.save
          session[:user_id] = @user.id
          session[:username] = @user.username
          format.html { redirect_to opinions_path, notice: 'User was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to opinions_path, notice: 'User was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to logout_path, notice: 'User was successfully destroyed.' }
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Nonexistent user id'
      redirect_to opinions_path
    end
  
    def user_params
      params.require(:user).permit(:username, :full_name, :photo, :cover_image)
    end
  end