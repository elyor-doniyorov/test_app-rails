class UsersController < ApplicationController
    def index
        redirect_to signup_url
    end
    def show
        
    end    
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save 
                session[:user_id] = @user.id
                session[:username] = @user.username
                format.html {redirect_to root_path, notice: "User has been created"}
            else
                format.html {render :new}
            end
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "User not Found"
        redirect_to opinions_path
    end

    def user_params
        params.require(:user).permit(:username, :fullname, :photo, :coverImage)   
    end
end
