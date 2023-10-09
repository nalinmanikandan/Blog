class UserCommentRatingsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    existing_rating = current_user.user_comment_ratings.find_by(comment: @comment)
    if existing_rating
      existing_rating.update(user_comment_rating_params)
      redirect_to topic_post_path(@topic,@post), notice: 'Rating already added.'
    else
      @user_comment_rating = current_user.user_comment_ratings.create(user_comment_rating_params)
      if @user_comment_rating.valid?
        redirect_to topic_post_path(@topic,@post), notice: 'Rating added successfully.'
      else
        # Handle validation errors
      end
    end
  end
  def index
    @comment = Comment.find(params[:comment_id])
    @commentratings = @comment.user_comment_ratings
  end
  def show
    @comment = Comment.find(params[:comment_id])
    @ratings = @comment.user_comment_ratings
  end

  private

  def user_comment_rating_params
    params.require(:user_comment_rating).permit(:comment_id, :rating)
  end
end
