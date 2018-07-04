class CommentsController < ApplicationController
 before_action :find_comment, only: [:show, :edit, :update, :destroy]

 def index
  @comments = Comment.all
 end

 def new
  @comment = Comment.new
 end

 def create
  @micropost = Micropost.find(params[:id])
  @comment = @micropost.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
   flash[:notice] = "Successfully created..."
   redirect_to comments_path
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
  if @comment.update
   flash[:notice] = "You updated your comment"
  else
   flash[:alert] = "Failed to update"
 end

 def destroy
  @comment.destroy
  redirect_to '/'
 end

 private

  def find_comment
   @comment = Comment.find(params[:id])
  end

  def comment_params
   params.require(:comment).permit(:comment)
  end
end
