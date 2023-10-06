class Post < ApplicationRecord
	self.per_page = 2
	belongs_to :topic
	has_many :comments, dependent: :destroy
	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables
	has_one_attached :image
	has_many :ratings
	belongs_to :user
	has_many :posts_users_read_statuses
	has_many :read_by_users, through: :posts_users_read_statuses, source: :user
end
