class RewardsController < ApplicationController
    # before_action :logged_in_user, only: [:create]
  def index
  
  end
  
  def show
    @user = User.find(params[:id])
    @map = Map.find_by(user_id: params[:id])
    @reward = RewardItem.all
  end
    
  # def create
  #   @reward = current_user.microposts.build(micropost_params)
  #   if @reward.save
  #     flash[:success] = "You have picked up a reward!"
  #     redirect_to user_url
  #   else
  #     render 'users/show'
  #   end
  # end
  
  # def update
  # end
  
  # private
  # def reward_params
  #   params.require(:reward).permit(:content)
  # end
end
