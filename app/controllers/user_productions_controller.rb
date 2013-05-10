#encoding: UTF-8
class UserProductionsController < ApplicationController
  def edit
    @user_production = UserProduction.find params[:id]
  end

  def update
    @user_production = UserProduction.find params[:id]
    respond_to do |format|
      if @user_production.update_attributes(params[:user_production])
        format.html { redirect_to display_path, notice: '编辑成功' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_production.errors, status: :unprocessable_entity }
      end
    end    
  end

end
