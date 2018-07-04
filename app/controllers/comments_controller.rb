class CommentsController < ApplicationController
 before_action :find_comment, only: [:show, :edit, :update, :destroy]

 def index
  @comments = Comment.all
 end

 def new
  @comment = Comment.new
 end

 def create
  # @micropost = Micropost.find(params[:id])
  @comment = Comment.new(comment_params)
  # @comment = current_user.comments.build(comment_params)
  # @comment.user = current_user

  if @comment.save
    respond_to do |format|
      format.html do
        flash[:notice] = "Successfully created..."
        redirect_to root_path
      end
      format.js
    end

  else
   flash[:alert] = "failed"
   redirect_to root_path
  end
 end

 def show
 end

 def edit
 end

 def update
  if @comment.update comment_params
   flash[:notice] = "You updated your comment"
   redirect_to root_path
  else
   flash[:alert] = "Failed to update"
   redirect_to 'edit'
  end
 end

 def destroy
  @comment.destroy
  flash[:success] = "Comment deleted"
  redirect_to request.referrer || root_url
 end

 private

  def find_comment
   @comment = Comment.find(params[:id])
  end

  def comment_params
   params.require(:comment).permit(:content, :micropost_id, :user_id)
  end

end
