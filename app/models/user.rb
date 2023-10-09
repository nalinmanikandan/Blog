class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_many :topics
  has_many :posts_users_read_statuses
  has_many :read_posts, through: :posts_users_read_statuses, source: :post
  has_many :user_comment_ratings
  has_many :rated_comments, through: :user_comment_ratings, source: :comment
  has_many :ratings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
