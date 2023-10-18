class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create :update_post_rating_average
  after_update :update_post_rating_average
  after_destroy :update_post_rating_average
  private
  def update_post_rating_average
    post.update_rating_average
  end
end
