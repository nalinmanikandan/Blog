# app/controllers/ratings_controller.rb
class RatingsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.new(rating_params)
    @rating.user = current_user
    @topic = @post.topic
    existingrating = current_user.ratings.find_by(post: @post)
    if existingrating
      existingrating.update(rating_params)
      redirect_to topic_post_path(@topic,@post), notice: 'Rating already added.'
    else
      if @rating.save
        redirect_to topic_post_path(@topic,@post), notice: "Rating created successfully."
      else
        render 'posts/show'
      end
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end

