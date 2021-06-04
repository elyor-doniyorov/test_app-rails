class OpinionsController < ApplicationController
    before_action :set_opinion, only: %i[show edit update destroy retweet]
    before_action :authenticate_user!, except: %i[index show]
  
    def index
      if current_user
        @opinions = current_user.followeds_opinions
        @users = current_user.who_follow
      else
        @opinions = Opinion.ordered_opinion.include_user_copied
        @users = User.ordered_users
      end
      @opinion = Opinion.new
    end
  
    def show; end
  
    def new
      @opinion = Opinion.new
    end
  
    def edit
      redirect_to opinions_path unless current_user == @opinion.user
    end
  
    def create
      @opinion = current_user.opinions.build(opinion_params)
      @opinions = current_user.followeds_opinions
      @users = current_user.who_follow
  
      respond_to do |format|
        if @opinion.save
          format.html { redirect_to opinions_path, notice: 'Opinion was successfully created.' }
        else
          format.html { render :index }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @opinion.update(opinion_params)
          format.html { redirect_to opinions_path, notice: 'Opinion was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  
    def destroy
      @opinion.destroy
      respond_to do |format|
        format.html { redirect_to request.referer, notice: 'Opinion was successfully deleted.' }
      end
    end
  
    def retweet
      current_user.copy_opi(@opinion)
      redirect_to opinions_path
    end
  
    private
  
    def set_opinion
      @opinion = Opinion.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Nonexistent post id'
      redirect_to opinions_path
    end
  
    def opinion_params
      params.require(:opinion).permit(:text)
    end
end