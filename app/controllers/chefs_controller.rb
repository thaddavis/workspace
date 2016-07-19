class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :show, :update]
  before_action :require_user, except: [:show, :index, :new]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 1)
  end

  def new
    @chef = Chef.new()
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Chef was created"
      session[:chef_id] = @chef.id
      redirect_to recipes_path
    else
      render 'new'
    end

  end

  def edit

  end

  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 1)
  end

  def update
    if @chef.update(chef_params)
      #do something
      flash[:success] = 'Chef was successfully edited'
      redirect_to chef_path(@chef)
    else
      render :edit
    end
  end

  def destroy
  end

  private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end

    def require_same_user
      if current_user != @chef
        flash[:danger] = 'You can only edit your own profile'
        redirect_to recipes_path
      end
    end

    def set_chef
      @chef = Chef.find(params[:id])
    end

end
