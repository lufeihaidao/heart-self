class Production < ActiveRecord::Base
  attr_accessible :img_url, :love_count, :make_at, :p_color, :p_pattern, :p_size, :p_type
  
  has_many :user_productions
  has_many :users, :through => :user_productions
end
