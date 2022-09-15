class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy authorized]
  before_action :authorized, only: %i[edit update destroy]

  def show; end

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    if @item.save!
      redirect_to root_path
    else
      render :new, notice: 'Oups, il y a eu un petit problème... si ça continue, appel ta soeur !'
    end
  end

  def edit
    @categories_instances = Category.all
    @categories_names = @categories_instances.map(&:title)
    @categories_ids = @categories_instances.map(&:id)
  end

  def update
    @item.update(item_params)
    redirect_to root_path, notice: 'Ton produit à bien été modifié ! Bien joué sister !'
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: 'Ton produit est passé du coté obscure de la force !'
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :quantity, :category_id, :photo)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def authorized
    authorize @item
  end
end
