class Topic < ApplicationRecord
	self.per_page = 2
	has_many :posts
	belongs_to :user
end
