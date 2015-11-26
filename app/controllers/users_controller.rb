class UsersController < ApplicationController
    before_action only: [:show, :edit, :update, :destroy] do |c|
        c.authenticate params[:id]
    end
    
    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    
    def show
        @user = User.find(params[:id])
        @post = @user.posts.build
        @posts = Post.all
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "User created!"
            redirect_to @user
        else
            flash.now[:danger] = "Something wrong"
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "User updated"
            redirect_to @user
        else
            flash.now[:danger] = "Something wrong"
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_url
    end
    
    private
    
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end
        

    
end
