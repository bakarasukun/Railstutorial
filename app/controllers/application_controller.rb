class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html: "test"
  end
  
  def test
      render html: "vector"
  end
end
