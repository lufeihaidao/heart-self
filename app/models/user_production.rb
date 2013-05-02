# == Schema Information
#
# Table name: user_productions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  production_id :integer          not null
#  order_at      :date             not null
#  is_loved      :boolean          default(FALSE)
#  is_sold       :boolean          default(FALSE)
#  sold_at       :date             default(Tue, 31 Dec 2999)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class UserProduction < ActiveRecord::Base
  attr_accessible :user, :production, :is_loved, :is_sold, :order_at, :production_id, :sold_at, :user_id, :bargain_price

  belongs_to :user
  belongs_to :production
end
