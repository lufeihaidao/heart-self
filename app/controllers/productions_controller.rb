class ProductionsController < ApplicationController
  def index
    @productions = Production.all
  end
  def new
    @user = current_user
    @p_type =params[:p_type]

  end
end
