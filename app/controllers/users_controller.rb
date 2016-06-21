class UsersController < ApplicationController
before_action :authenticate_user!, only: [:update]

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
    
    # if @user.map_id = nil &&
    #TODO　新しいマップデータを作る
    #     @map = Map.new()
    # else
    #TODO  既存のマップデータを呼び出す
    #     @map = Map.find()

    #TODO　既存のコレクションデータを呼び出す
    #     @stampcode = Stampcode.find()
      stampcode_all = StampCode.where(user_id: current_user)
      @stamp_all = Array.new
      stampcode_all.each do |stampcode|
        p @stamp_all << Stamp.find_by(id: stampcode.stamp_id)
      end     
      @stampcode = StampCode.create()

    # end
  end
  
  
  def update
    # TODO 入力時コードのバリデーション
    
    code = params[:code]
    
    #一意性チェック
    stampcode = StampCode.where(code: code)
    if stampcode != nil
      flash[:notice] = "既にこのコードは使用されました。"
      render :show
      return
    end
      
    # コードの中のidを取り出す
    @code_id = code[]
    stamp = Stamp.find_by(id: @code_id)
    
    #stamp_idのチェック処理
    if stamp != nil
      StampCode.create(code: params[:code], user_id: current_user,
                       stamp_id: @code_id
                       )
      stampcode_all = StampCode.where(user_id: current_user)
      @stamp_all = Array.new
      stampcode_all.each do |stampcode|
        p @stamp_all << Stamp.find_by(id: stampcode.stamp_id)
      end     

      redirect_to @stamp_all
    else
　    #stamp_idのが間違いの場合
      flash[:notice] = "コードに誤りがあります。"
      render :show
      return
    end
    
    # @stampcode_all = StampCode.where(user_id: current_user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def authenticate_user!
    # current_userが@userでない時はroot_pathなどにリダイレクト
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end  
  end
    
    
end
