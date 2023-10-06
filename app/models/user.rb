class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_many :topics
  has_many :posts_users_read_statuses
  has_many :read_posts, through: :posts_users_read_statuses, source: :post
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
