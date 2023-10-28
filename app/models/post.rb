class Post < ApplicationRecord
	self.per_page = 4
	belongs_to :topic
	has_many :comments, dependent: :destroy
	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables
	has_one_attached :image
	has_many :ratings, dependent: :destroy
	belongs_to :user
	has_many :posts_users_read_statuses, dependent: :destroy
	has_many :read_by_users, through: :posts_users_read_statuses, source: :user
	scope :created_between, ->(from_date, to_date) {
		where(created_at: from_date.beginning_of_day..to_date.end_of_day)
	}
	def update_rating_average
		update(rating_average: ratings.average(:value))
	end
end
