class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy 

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      render :json => 'micropost saved'
      #flash[:success] = 'micropost saved'
      #redirect_to root_url
    else
      render :json => 'failed to save micropost'
    end
  end

  def destroy
    if @micropost.destroy
      render 'microposts/success', formats: 'json', handlers: 'jbuilder'
    else
      render 'microposts/failed', formats: 'json', handlers: 'jbuilder'
    end
    #flash[:success] = 'Micropsot deleted'
    #redirect_to request.referrer || root_url 
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
