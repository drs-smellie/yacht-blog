class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
		authorize! :create, Post, message: "You need to be an admin to create a new post."
	end

	def create
		@post = current_user.posts.build(post_params)
		authorize! :create, @post, message: "You need to be an admin to do that."
		if @post.save
			redirect_to @post, notice: "Post was created successfully!"
		else
			flash[:error] = "Error creating topic. Please try again."
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
		authorize! :edit, @post, message: "You need to be an admin to do this."
	end

	def update
		@post = Post.find(params[:id])
		authorize! :update, @post, message: "You need to be an admin to do this."
		if @post.update(params[:post].permit(:title, :text))
			flash[:notice] = "Post was updated."
			redirect_to @post
		else
			flash[:error] = "There was an error saving the post. Please try again."
			render :edit
		end
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@comment = Comment.new
	end

	def destroy
		@post = Post.find(params[:id])
		authorize! :destroy, @post, message: "You need to be an admin to do this!"
		
		if @post.destroy
			flash[:notice] = "Post was removed!"
		else
			flash[:error] = "There was an error deleting the comment. Please try again."
		end
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title, :text)
	end
end
