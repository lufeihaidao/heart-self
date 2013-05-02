class Dot < ActiveRecord::Base
  belongs_to :production
  attr_accessible :latitude, :longitude
end
