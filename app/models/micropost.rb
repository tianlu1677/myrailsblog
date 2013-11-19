class Micropost < ActiveRecord::Base
	#add tianlu
	validates :content, length: { maximum: 140 }
	belongs_to :user
end
