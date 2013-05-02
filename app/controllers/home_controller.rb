class HomeController < ApplicationController
  def index
    @users = User.all
  end
  def custom
    @production = Production.new
  end
  def taobao
    #@user = current_user
  end
  def display
    #@user = current_user
  end
  def quality
    #@user = current_user
  end
end
