class RecipesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]

    def index
        @recipes = Recipe.all
    end

    def show
    end

    def new
        @recipe = current_user.recipes.build
    end

    def create
        recipe = @recipe = current_user.recipes.build(recipe_params)
        if recipe.save
            redirect_to recipe_path(recipe)
        else
            redirect_to new_recipe_path
        end
    end

    def edit
    end

    def update
        if @recipe.update recipe_params
            redirect_to recipe_path(@recipe)
        else
            redirect_to edit_recipe_path(@recipe)
        end
    end

    def destroy
        @recipe.destroy
        redirect_to recipes_path
    end


    private
    #Strong parameters
    def recipe_params
        params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
    end

    def set_recipe
        @recipe = Recipe.find params[:id]
    end
end
