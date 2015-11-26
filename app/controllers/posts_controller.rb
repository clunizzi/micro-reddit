class PostsController < ApplicationController
    before_action only: [:update, :destroy] do |c|
        if !params.has_key? :post
            c.authenticate params[:user_id]
        else
            c.authenticate params[:post][:user_id]
        end
    end
    
    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
    end
    
    def create
        @user = User.find(params[:post][:user_id])
        @post = @user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created"
            redirect_to @user
        else
            flash[:danger] = "Something wrong" 
            redirect_to @user
        end
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        @user = @post.user
        if @post.update_attributes(post_params)
            flash[:success] = "Post edited!"
            redirect_to @user
        else
            flash.now[:danger] = "Something wrong with your post!" 
            render @user
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @user = @post.user
        @post.destroy
        redirect_to @user
    end
    
    private
        def post_params
            params.require(:post).permit(:link, :content)
        end
end
