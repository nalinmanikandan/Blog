class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :find_topic
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = @topic.posts.find(params[:id])
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

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params)

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
    @post = @topic.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to topic_path(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

end
