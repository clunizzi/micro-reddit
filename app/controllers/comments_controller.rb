class CommentsController < ApplicationController
    
    def create
        @post = Post.find(params[:comment][:post_id])
        @comment = @post.comments.build(comment_params)
        if (@user = User.find_by username: params[:comment][:commenter])
            @comment.user_id = @user.id
        else
            @comment.user_id = 0
        end
        if @comment.save
            flash[:create] = "Comment create!"
            redirect_to @post
        else
            flash[:danger] = "Something goes wrong!"
            redirect_to @post
        end
    end
    
    private
        
        def comment_params
            params.require(:comment).permit(:commenter, :content)
        end
end
