class ProductionsController < ApplicationController
  def index
    @productions = Production.all
  end
  def new
    # @user = current_user
    p_type =params[:p_type]
    @production = Production.new
    @production.p_type = p_type
    if p_type != 'facet' && p_type != 'radial'
    	redirect_to custom_path
    end
    
  end
end
