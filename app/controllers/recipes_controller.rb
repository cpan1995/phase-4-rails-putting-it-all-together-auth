class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :show_errors
    def index 
        user = User.find_by(id: session[:user_id])
        if user
            render json: Recipe.all, status: 201
        else
            render json: {errors: ["Nope"]}, status: 401
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            new_recipe = user.recipes.create!(recipes_params)
            render json: new_recipe, status: 201
        else
            render json: {errors: ["Nope"]}, status: 401
        end
    end

    private

    def show_errors(e)
        render json: {errors: e.record.errors.full_messages}, status: 422
    end

    def recipes_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
