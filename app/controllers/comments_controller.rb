class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@comments = @post.comments

		@comment = current_user.comments.build(comment_params)
		@comment.post = @post
		@new_comment = Comment.new
		redirect_to post_path(@post)

		authorize! :create, @comment, message: "You need to be signed up to do that."
		if @comment.save
			flash[:notice] = "Comment was saved!"
		else
			flash[:error] = "There was an error saving the comment. Please try again."
		end

	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		authorize! :destroy, @comment, message: "You need to own the comment to delete it."
		if @comment.destroy
			flash[:notice] = "Comment was removed."
		else
			flash[:error] = "There was an error deleting the comment. Please try again."
		end
		redirect_to post_path(@post)
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
