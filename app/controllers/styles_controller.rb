class StylesController < ApplicationController
  before_action :require_user, except: [:show]

  def new
    @style = Style.new()
  end

  def show
    @style = Style.find(params[:id])
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 1)
  end

  def create
    @style = Style.new(style_params)

    if @style.save
      #do something
      flash[:success] = 'Style was successfully created'
      redirect_to recipes_path
    else
      render :new
    end
  end

  private
    def style_params
      params.require(:style).permit(:name)
    end

end
