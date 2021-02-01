class V1::PostsController < ApplicationController
    def all
        render json: Post.all.limit(params[:limit].to_i || 25).offset(params[:offset].to_i || 0), status: :ok
    end

    def get_post
        render json: Post.find(params[:postId]), status: :ok
    end

    def create
        post = Post.new(params.require(:userId).permit(:title, :thumb, :content), user_id: params[:userId])
        assert_save post
        render json: post, status: :create
    end

    def delete
        post = Post.find(params[:postId])
        post.destroy
        render json: { success: true }, status: :ok
    end

    def update
        post = Post.find(params[:postId])
        edit_object(post)
        render json: post, status: :ok
    end

end
