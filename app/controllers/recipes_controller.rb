class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :update, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_same_user, only: [:edit, :update, :like]

  def index
    #@recipes = Recipe.all.sort_by{ |likes| likes.thumbs_up_total }.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 1)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save
      #do something
      flash[:success] = 'Recipe was successfully created'
      redirect_to recipes_path
    else
      render :new
    end

  end

  def edit

  end

  def show

  end

  def update

    if @recipe.update(recipe_params)
      #do something
      flash[:success] = 'Recipe was successfully edited'
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = 'Successfully submitted your request'
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = 'You can only vote once per recipe'
      redirect_to :back
    end
  end

  def destroy
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [])
    end

    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = 'You can only edit your own recipes'
        redirect_to root_path
      end
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

end
