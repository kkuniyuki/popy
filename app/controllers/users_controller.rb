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
    @stampcode = StampCode.new()
    
    if @user.map_id == nil 
       
       @map = Map.new(user_id: params[:id])
    
    else

    #TODO  既存のマップデータを呼び出す
      @map = Map.find(user_id: params[:id])

    #TODO　既存のコレクションデータを呼び出す
      stampcode_all = StampCode.where(user_id: current_user)
      @stamp_all = Array.new
      stampcode_all.each do |stampcode|
        @stamp_all << Stamp.find_by(id: stampcode.stamp_id)
      end     

    end


  end
  
  
  def update
    p code = params[:code]
    
    #一意性チェック
    p stampcode = StampCode.find_by(code: code)
    if stampcode != nil
      flash[:notice] = "既にこのコードは使用されました。"
      render :show
      return
    end
      
    # コードの中のidを取り出す
    p @code_id = code[8]
    p stamp = Stamp.find_by(id: @code_id)
    
    #stamp_idのチェック処理
    if stamp != nil
      p "koko"
      stampcode = StampCode.create(code: params[:code], user_id: current_user.id,
                                    stamp_id: @code_id
                                     )
      if  stampcode.valid?
        stampcode.save
      else
        flash[:notice] = stampcode.errors.messages
        render :show
        return
      end
      
                                     
      p stampcode_all = StampCode.where(user_id: current_user)
      @stamp_all = Array.new
      stampcode_all.each do |stampcode_i|
        p @stamp_all << Stamp.find_by(id: stampcode_i.stamp_id)
      end     
      p @stamp_all
      render :show

    else
  
      flash[:notice] = "コードに誤りがあります。"
      render :show
      return
    end
    
    # @stampcode_all = StampCode.where(user_id: current_user)
  end
  
  
  def stamp_update
    stampimage = Stamp.find(image: params[:stamp_image])
    @map = Map.find(user_id: current_user.id)

    unless @map.status"#{stampimage.id}".blank?
      @map.update(status"#{stampimage.id}": true)
      flash[:notice] = "マップがひとつ埋まりました"
      
      stampcde = StampCode.find(user_id: current_user.id, stamp_id: stampimage.id)
      stampcde.destroy
      render :show
      
    else
      flash[:notice] = "すでに埋まっているか、今回のマップでは使えません。"
      render :show
    end
    
    
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
