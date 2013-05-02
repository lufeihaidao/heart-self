class UserProduction < ActiveRecord::Base
  attr_accessible :user, :production, :is_loved, :is_sold, :order_at, :production_id, :sold_at, :user_id

  belongs_to :user
  belongs_to :production
end
