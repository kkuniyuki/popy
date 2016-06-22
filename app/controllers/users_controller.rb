class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if  @user.save
      redirect_to "/welcomes/#{@user.id}", alert: "会員登録が完了しました"
    else
      render 'new'
      return
    end
  end
  
  
  def show
    set_user
    
    # 初回ユーザーチェック
    if @user.map_id == nil 
      @map = Map.new(user_id: @user.id, image:"/images/map.png")
      unless @map.save
        render 'new'
        return
      end

    # 　ユーザーにマップを紐付ける
      map = Map.find_by(user_id: @user.id)
      @user.update(map_id: map.id)
      @user.save

      # @stamp_all = Array.new
    else
      #既存のマップとコレクションデータを呼び出す
      @map = Map.find_by(user_id: params[:id])
      stampcode_all_user
    end


  end
  
#コード入力処理
  def update
    set_user
    @map = Map.find_by(user_id: params[:id])

    #コードの一意性チェック
    code = params[:code]
    stampcode = StampCode.find_by(code: code)
    if stampcode != nil
      flash[:alert] = "既にこのコードは使用されました。"
      render :show
      return
    end
      
    # コードの中のスタンプidを取り出す
    @code_id = code[8]
    stamp = Stamp.find_by(id: @code_id)
    
    #stamp_idのチェック処理
    if stamp != nil
    #stampcodeの保存
      stampcode = StampCode.create(code: params[:code], user_id: params[:id],
                                    stamp_id: @code_id
                                     )
      stampcode.save
      
    #stampコレクションをshowへ表示
      stampcode_all_user                               
      render :show

    else
      stampcode_all_user        
      flash[:alert] = "コードに誤りがあります。"
      render :show
      return
    end
    
  end
  
  
#スタンプが使われた時の処理
  def stamp_update
    set_user
    @map = Map.find_by(user_id: params[:id])
    
    # 使われたスタンプセット
    stampimage = Stamp.find_by(image: params[:image])
    
    # マップ状況とチェック、更新
    case stampimage.id
    when 1 then
      if @map.status1 == "f"
        @map.update(status1: true)
      else
        stampcode_all_user        
        flash[:alert] = "すでに埋まっています。"
        render :show
        return
      end

    when 2 then   
      if @map.status2 == "f"
        @map.update(status2: true)
      else
        stampcode_all_user
        flash[:alert] = "すでに埋まっています。"
        render :show
        return
      end

    when 3 then
      if @map.status3 == "f"
        @map.update(status3: true)
      else
        stampcode_all_user
        flash[:alert] = "すでに埋まっています。"
        render :show
        return
      end

    when 4 then
      if @map.status4 == "f"
        @map.update(status4: true)
      else
        stampcode_all_user
        flash[:alert] = "すでに埋まっています。"
        render :show
        return
      end
    
    else
      stampcode_all_user        
      flash[:alert] = "今回のマップでは使えません。"
      render :show
      return
    end
    
    flash[:alert] = "マップがひとつ埋まりました"

    # 使われたスタンプを削除
    stampcde = StampCode.find_by(user_id: params[:id], stamp_id: stampimage.id)
    stampcde.destroy
    stampcode_all_user        
    render :show
  end
  
  
  

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :map_id)
  end


  def stampcode_all_user
    stampcode_all = StampCode.where(user_id: params[:id])
    @stamp_all = Array.new
    stampcode_all.each do |stampcode_i|
      @stamp_all << Stamp.find_by(id: stampcode_i.stamp_id)
    end
    @stamp_all
  end
  
  # def downcase
  #   flash[:alert] = "すでに埋まっています。"
  #   render :show
  #   return
  # end
  
  # def authenticate_user!
  #   # current_userが@userでない時はroot_pathなどにリダイレクト
  #   @user = User.find(params[:id])
  #   if @user != current_user
  #     redirect_to root_path
  #   end  
  # end
    
    
end