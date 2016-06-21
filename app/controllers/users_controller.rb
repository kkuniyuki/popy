class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "会員登録が完了しました"
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    # if @user.map_id = nil
    #TODO　新しいマップデータを作る
    #     @map = Map.new()
    #TODO　新しいコレクションデータを作る
    #     @map = Map.new()
    # else
    #TODO  既存のマップデータを呼び出す

    #TODO　既存のコレクションデータを呼び出す
    #     @map = Map.new()
        
    # end

  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
    
    
end
