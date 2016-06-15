class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
    respond_to do |format|
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  def show
    respond_to do |format|
      format.json { render json: @post }
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    #guests can only read
    unless @post.user.guest?
      respond_to do |format|
        if @post.save
          format.json { render json: @post, status: :created }
        else
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    #guests can only read
    unless @post.user.guest?
      respond_to do |format|
        #user can only edit/update his posts, admin can edit/update any
        if ((@post.user.user? and (params[:post][:user] == @post.user)) or @post.user.admin?)
          if @post.update_attributes(params[:post])
            format.json { head :no_content, status: :ok }
          else
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /posts/1
  def destroy
    #guests can only read
    unless @post.user.guest?
      respond_to do |format|
        #user can only edit/update his posts, admin can edit/update any
        if ((@post.user.user? and (params[:post][:user] == @post.user)) or @post.user.admin?)
          @post.destroy
          format.json { head :no_content, status: :ok }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :description)
    end
end
