# app/controllers/ratings_controller.rb
class RatingsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.new(rating_params)
    @topic = @post.topic
    if @rating.save
      redirect_to topic_posts_path(@topic), notice: "Rating created successfully."
    else
      render 'posts/show'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end

