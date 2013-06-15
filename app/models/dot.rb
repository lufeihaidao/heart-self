# == Schema Information
#
# Table name: dots
#
#  id            :integer          not null, primary key
#  latitude      :string(255)      not null
#  longitude     :string(255)      not null
#  production_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Dot < ActiveRecord::Base
  belongs_to :production
  attr_accessible :x, :y, :city_name
end
