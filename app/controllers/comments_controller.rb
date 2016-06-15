class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  def show
    respond_to do |format|
      format.json { render json: @comment }
    end
  end

  # POST /comments
  def create
    @comment = Comment.new(post_params)
    #guests can only read
    unless @comment.post.user.guest?
      respond_to do |format|
        if @comment.save
          format.json { render json: @comment, status: :created }
        else
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    #guests can only read
    unless @comment.user.guest?
      respond_to do |format|
        #user can only edit/update his posts, admin can edit/update any
        if ((@comment.post.user.user? and (params[:comment][:post][:user] == @comment.post.user)) or @comment.post.user.admin?)
          if @comment.update_attributes(params[:comment])
            format.json { head :no_content, status: :ok }
          else
            format.json { render json: @comment.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /comments/1
  def destroy
    #guests can only read
    unless @comment.post.user.guest?
      respond_to do |format|
        #user can only edit/update his posts, admin can edit/update any
        if ((@comment.post.user.user? and (params[:comment][:post][:user] == @comment.post.user)) or @comment.post.user.admin?)
          @comment.destroy
          format.json { head :no_content, status: :ok }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:description)
    end
end
