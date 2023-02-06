class ItemsController < ApplicationController

  def index
      if params[:user_id]
        user = User.find_by(id: params[:user_id])
        items = user ? user.items : false
    
        if items
          return render json: items
        else
          return render json: {error: "items not found"}, status: :not_found
        end
      else
        items = Item.all
        if items
          return render json: items, include: :user
        else 
          return render json: {error: "items not found"}, status: :not_found
      end
    end
  end

  def show
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      item = user ? user.items.find_by(id: params[:id]) : false
      if item
        return render json: item
      else
        return render json: { error: "item not found"}, status: :not_found
      end
    else
      item = Item.find_by(id: params[:id])
      return render json: item, include: :user
    end
  end

  def create
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      item = user.items.create(name: params[:name], description: params[:description], price: params[:price])
      return render json: item, status: :created
    end
  end

end
