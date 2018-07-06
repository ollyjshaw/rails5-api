module Api
    class UsersController < ApplicationController
        def create
            @user = User.new(user_params)
            if @user.save
                head :created
            else
              render json: @user.errors, status: :unprocessable_entity
            end
        end

        def index
            @users = User.order('created_at DESC')
        end
         
        private
         
        def user_params
            params.require(:user).permit(:name)
        end
    end
end