class IngredientsController < ApplicationController
  before_action :require_user, except: [:show]

  def new
    @ingredient = Ingredient.new()
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 1)
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      #do something
      flash[:success] = 'Ingredient was successfully created'
      redirect_to recipes_path
    else
      render :new
    end
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

end
