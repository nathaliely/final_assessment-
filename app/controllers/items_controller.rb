class ItemsController < ApplicationController

  before_action :find_item, only: [:show, :edit, :update, :destroy]


  def index
    @items = Item.where(:user_id => current_user.id).order("created_at DESC")
  end

  def new
  @item = current_user.items.new
    respond_to do |format|
      format.html {render :new}
      format.js
    end
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      store_images
      @item_json = @item.to_json
      respond_to do |format|
        format.html {redirect_to @item}
        format.js
      end
    else
      respond_to do |format|
        format.html {render :new}
        format.js
      end
    end
  end


  def edit
  end

  def update
    if @item.update(item_params)
      store_images
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def complete
    @item = Item.find(params[:id])
    @item.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end


  def search
        @items = Item.title(params[:search][:title])

        if @items.blank?
          redirect_to items_path, flash:{danger: "no successful search result"}
        else
          render :index
        end
  end

  private

def item_params
  params.require(:item).permit(:title, :description)
end

def find_item
  @item = Item.find(params[:id])
end

def store_images
  images = params[:item][:pictures]
  images.each{|image| @item.images.create(image: image)} if images
end

end
