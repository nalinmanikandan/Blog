class Post < ApplicationRecord
	belongs_to :topic
	has_many :comments, dependent: :destroy
	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables
end
