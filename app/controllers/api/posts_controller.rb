module Api
    class PostsController < ApplicationController
        include ActionController::HttpAuthentication::Token::ControllerMethods
        before_action :authenticate, only: [:create, :destroy]
        def index
            @posts = Post.order('created_at ASC')
        end

        def create
            @post = @user.posts.new(post_params)
            if @post.save
                render json: @post, status: :created
            else
                render json: @post.errors, status: :unprocessable_entity
            end
        end

        def destroy
            @post = @user.posts.find_by(id: params[:id])
            if @post
              @post.destroy
              head :no_content #that's what gets returned anyways
            else
              puts "params" + params[:id]
              render json: {post: "not found"}, status: :not_found
            end
        end

        private

        def post_params
            params.require(:post).permit(:title, :body)
        end 

        def authenticate
            authenticate_or_request_with_http_token do |token, options|
              @user = User.find_by(token: token)
            end
        end
    end
end