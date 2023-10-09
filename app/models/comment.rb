class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :user_comment_ratings
  has_many :users_who_rated, through: :user_comment_ratings, source: :user
end
