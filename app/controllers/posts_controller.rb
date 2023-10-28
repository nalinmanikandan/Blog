class PostsController < ApplicationController
  before_action :find_topic
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
    def index
      if params[:from_date].present? && params[:to_date].present?
        from_date = Date.parse(params[:from_date])
        to_date = Date.parse(params[:to_date])
      else
        from_date = 1.day.ago.to_date
        to_date = Date.today
      end
      if params[:topic_id]
        # List posts for a specific topic
        @topic = Topic.find(params[:topic_id])
        @posts = @topic.posts.created_between(from_date,to_date).paginate(page:params[:page])
      else
        @posts = Post.created_between(from_date,to_date).paginate(page:params[:page])
      end
    end
    @ratings = Rating.where(post: @posts)
    @comments_count = {}
    if @posts
      @posts.each do |post|
        comments_count = post.comments.count
        @comments_count[post.id] = comments_count
      end
    end
    #render json: @posts, status: :ok

  # GET /posts/1 or /posts/1.json
  def show
    @post = @topic.posts.find(params[:id])
    @tags = @post.tags
    @posts = @topic.posts
    @ratings = Rating.where(post: @posts)
    @comments = @post.comments.includes(:user)
    #render json: @organization
  end

  # GET /posts/new
  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build
  end

  # GET /posts/1/edit
  def edit
    @post = @topic.posts.find(params[:id])
  end

  def mark_as_read
    post = Post.find(params[:post_id])
    current_user.read_posts << post unless current_user.read_posts.include?(post)
    render json: { success: true }
  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    if @post.save
        redirect_to topic_posts_path(@topic), notice: "Post was successfully created."
        #render json: @post, status: :created
      else
        render :new, status: :unprocessable_entity
        #render json: @post.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = @topic.posts.find(params[:id])

      if @post.update(post_params)
        redirect_to topic_post_path(@topic,@post), notice: "Post was successfully updated."
        #render json:@post, status: :ok
      else
        render :edit, status: :unprocessable_entity
        render json: @post.errors, status: :unprocessable_entity
      end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.tags.destroy
    @post.destroy
      redirect_to topic_posts_path(@topic), notice: "Post was successfully destroyed."
      head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :ratings,tag_ids: [])
    #params.require(:post).permit(:title, :content, :topic_id, tag_ids: [])
  end
  def find_topic
    @topic = Topic.find(params[:topic_id]) if params[:topic_id].present?
  end
  def set_post
    @post = @topic.posts.find(params[:id])
  end

end
