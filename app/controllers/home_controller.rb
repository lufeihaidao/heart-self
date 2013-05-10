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
    @user_production_grid = initialize_grid(UserProduction)
  end
  def quality
    #@user = current_user
  end
end
