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
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.created_between(from_date,to_date).paginate(page:params[:page])
    @comments_count = {} # Calculate comments count for each post
    @posts.each do |post|
      comments_count = post.comments.count
      @comments_count[post.id] = comments_count
    end
    @ratings = Rating.where(post: @posts)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = @topic.posts.find(params[:id])
    @tags = @post.tags
    @posts = @topic.posts
    @ratings = Rating.where(post: @posts)
    @comments = @post.comments.includes(:user)
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
    #create_or_delete_posts_tags(@post, params[:post][:tags])
    respond_to do |format|
      if @post.save
        format.html { redirect_to topics_path(@topic), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = @topic.posts.find(params[:id])
    #create_or_delete_posts_tags(@post, params[:post][:tags])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to topic_post_path(@topic,@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.tags.destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to topic_path(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  #def create_or_delete_posts_tags(post, tags)
  # post.taggables.destroy_all
  # tags = tags.strip.split(',')
  # tags.each do |tag|
  #   post.tags << Tag.find_or_create_by(name:tag)
  # end
  #end
  # Use callbacks to share common setup or constraints between actions.
  def post_params
    params.require(:post).permit(:title, :content, :image, :ratings,tag_ids: [])
    #params.require(:post).permit(:title, :content, :topic_id, tag_ids: [])
  end
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
  def set_post
    @post = @topic.posts.find(params[:id])
  end

end
