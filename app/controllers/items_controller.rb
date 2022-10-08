class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    elsif
      items = Item.all
    else
      render json: {error:"Item not found"}, status: :not_found
    end
    render json: items, include: :user

  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.find(params[:id])
    else
      item = user.items
    end
    render json: item, include: :user, status: :ok
  end

  def create
    if params[:id]
      user = User.items.find(params[:id])
      item = Item.create(item_params)
    else
      item = Item.create(item_params)
    end
    render json: item, include: :user, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def render_not_found_response
    render json: {error: "Item not found"}, status: :not_found
  end
end
