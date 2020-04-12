class UserController < ApplicationController
  def show
    render formats: 'json', handlers: 'jbuilder'
  end
end
