class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).includes(:user)
    end
  end

  def api
    if current_user 
      @feed_items = current_user.feed.paginate(page: params[:page]).includes(:user)
    else
      @feed_items = nil
    end
    render formats: 'json', handlers: 'jbuilder'
  end

  def help
  end

  def about
  end
  
  def contact
  end
  
  def test
  end
end