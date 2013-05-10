# == Schema Information
#
# Table name: user_productions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  production_id :integer          not null
#  order_at      :datetime         not null
#  bargain_price :integer          not null
#  is_loved      :boolean          default(FALSE)
#  is_sold       :boolean          default(FALSE)
#  sold_at       :datetime         default(2999-12-31 16:00:00 UTC)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class UserProduction < ActiveRecord::Base
  attr_accessible :user, :production, :is_loved, :is_sold, :order_at, :production_id, :sold_at, :user_id, :bargain_price

  belongs_to :user
  belongs_to :production

  # validates :is_sold, :presence => true
  validates :bargain_price, :presence => true  
end
