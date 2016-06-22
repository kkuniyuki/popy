class ItemsController < ApplicationController
  def index
  
  end
  
  def show
    @user = User.find(params[:id])
    @map = Map.find_by(user_id: params[:id])
    @reward = RewardItem.all
  end
end
