class RecipesController < ApplicationController
    before_action :authorize

    def index
        render json: Recipe.all
    end

    def create
        recipe = Recipe.create(recipe_params)
        render json: recipe, status: :created
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, session[:user_id])
    end

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end
end
