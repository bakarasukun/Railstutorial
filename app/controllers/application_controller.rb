class ApplicationController < ActionController::Base
  include SessionsHelper
  
  protect_from_forgery with: :exception
  def hello
    render html: 'Hello World!'
  end
  
  def test
    render html: 'vector'
  end
end
