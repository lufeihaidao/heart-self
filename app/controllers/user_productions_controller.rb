#encoding: UTF-8
class UserProductionsController < ApplicationController
  def edit
    @user_production = UserProduction.find params[:id]
  end

  def update
    @user_production = UserProduction.find params[:id]
    if @user_production.update_attributes(params[:user_production])
      # flash[:success] = "编辑成功"
      redirect_to display_path
    else
      render 'edit'
    end
  end

end
