class ApiController < ApplicationController
  def user_api
    render formats: 'json', handlers: 'jbuilder'
  end

  def feed_api
    if current_user 
      @feed_items = current_user.feed.paginate(page: params[:page]).includes(:user)
    else
      @feed_items = nil
    end
    render formats: 'json', handlers: 'jbuilder'
  end
end
