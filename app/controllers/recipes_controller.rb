class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all.sort_by{ |likes| likes.thumbs_up_total }.reverse
    #@recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(1)

    if @recipe.save
      #do something
      flash[:success] = 'Recipe was successfully created'
      redirect_to recipes_path
    else
      render :new
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      #do something
      flash[:success] = 'Recipe was successfully edited'
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = 'Successfully submitted your request'
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = 'You can only vote once per recipe'
      redirect_to recipe_path(@recipe)
    end
  end

  def destroy
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end

end
