class HomeController < ApplicationController
  def index
    @users = User.all
  end
  def custom
    @user = current_user
  end
end
