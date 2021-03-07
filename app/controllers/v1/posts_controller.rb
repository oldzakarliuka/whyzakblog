class V1::PostsController < ApplicationController
    before_action :authorized, only: [:create, :update, :delete]
    def all
        render json: Post.all.reverse_order.limit(params[:limit] || 25).offset(params[:offset] || 0), status: :ok
    end

    def get_post
        render json: Post.find(params[:postId]), status: :ok
    end

    def create
        post = Post.new(params.permit(:title, :thumb, :content).merge({user_id: @user[:id]}))
        assert_save post
        render json: post, status: :created
    end

    def delete
        post = Post.find(params[:postId])
        raise Err::Exceptions::DeletePostOtherUser unless post[:user_id] == @user[:id]
        post.destroy
        render json: { success: true }, status: :ok
    end
    
    def update
        post = Post.find(params[:postId])
        raise Err::Exceptions::UpdPostOtherUser unless post[:user_id] == @user[:id]
        edit_object(post)
        render json: post, status: :ok
    end

end
