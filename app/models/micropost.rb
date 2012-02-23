class Micropost < ActiveRecord::Base
	validates :content, :length => {:maximum => 100 } 
	belongs_to :user
end
