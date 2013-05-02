# == Schema Information
#
# Table name: productions
#
#  id         :integer          not null, primary key
#  make_at    :date             not null
#  p_type     :string(255)      not null
#  p_pattern  :string(255)      not null
#  p_color    :string(255)      not null
#  p_size     :string(255)      not null
#  love_count :integer          default(0), not null
#  img_url    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  p_material :string(255)
#  price      :integer
#

class Production < ActiveRecord::Base
  attr_accessible :img_url, :love_count, :make_at, :p_color, :p_pattern, :p_size, :p_type, :p_material, :price
  
  has_many :user_productions
  has_many :users, :through => :user_productions
  has_many :dots
end
