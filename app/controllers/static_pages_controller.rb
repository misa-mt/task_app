class StaticPagesController < ApplicationController
  before_action :logged_in?
  
  
  def top
  end
  
  def logged_in?
    !current_user.nil?
  end
  
end
