class UsersController < ApplicationController

  def new
    p "koko"
    @user = User.new
  end
  
  def create
    p "koko2"
    @user = User.new(user_params)
    if  @user.save
    p "koko3"
      redirect_to @user, notice: "会員登録が完了しました"
    else
    p "koko4"
      render 'new'
      return
    end
  end
  
  
  def show
    @user = User.find(params[:id])
    p "koko5"

    if @user.map_id == nil 
    p "koko6"
      @map = Map.new(user_id: @user.id, image:"/images/map.png")
      unless @map.save
    p "koko7"
        render 'new'
        return
      end

      @stamp_all = Array.new
      map = Map.find_by(user_id: @user.id)
      @user.update(map_id: map.id)
      @user.save
    else
    p "koko8"
      @map = Map.find_by(user_id: params[:id])

    #TODO　既存のコレクションデータを呼び出す
      stampcode_all = StampCode.where(user_id: current_user)
      @stamp_all = Array.new
      stampcode_all.each do |stampcode|
       p "koko9"
        @stamp_all << Stamp.find_by(id: stampcode.stamp_id)
      end     

    end


  end
  
  
  def update
    p "koko10"
    @user = User.find(params[:id])
    p code = params[:code]
    # p Map.all
    p @map = Map.find_by(user_id: params[:id])

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
      stampcode = StampCode.create(code: params[:code], user_id: params[:id],
                                    stamp_id: @code_id
                                     )
      p stampcode.save
      # p stampcode.errors.messages
      #   flash[:notice] = stampcode.errors.messages
      #   render :show
      #   return

                                     
      p stampcode_all = StampCode.where(user_id: params[:id])
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
    
  end
  
  
  def stamp_update
    @user = User.find(params[:id])
    p "koko20"
    p params[:image]
    p Stamp.all
    stampimage = Stamp.find_by(image: params[:image])
    @map = Map.find_by(user_id: params[:id])
    
    case stampimage.id
    when 1 then
      if @map.status1 == "f"
        @map.update(status1: true)
      else
　　　  flash[:notice] = "すでに埋まっています。"
        render :show
        return
      end

    when 2 then   
      if @map.status2 == "f"
        @map.update(status2: true)
      else
        flash[:notice] = "すでに埋まっています。"
        render :show
        return
      end

    when 3 then
      if @map.status3 == "f"
        @map.update(status3: true)
      else
        flash[:notice] = "すでに埋まっています。"
        render :show
        return
      end

    when 4 then
      if @map.status4 == "f"
        @map.update(status4: true)
      else
        flash[:notice] = "すでに埋まっています。"
        render :show
        return
      end
    
    else
      flash[:notice] = "今回のマップでは使えません。"
      render :show
      return
    end
    
    flash[:notice] = "マップがひとつ埋まりました"
    stampcde = StampCode.find_by(user_id: params[:id], stamp_id: stampimage.id)
    stampcde.destroy
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


  # def stampcode_all_user
  #   stampcode_all = StampCode.where(user_id: params[:id])
  #   @stamp_all = Array.new
  #   stampcode_all.each do |stampcode_i|
  #     @stamp_all << Stamp.find_by(id: stampcode_i.stamp_id)
  #   end
  #   @stamp_all
  # end
  
  # def authenticate_user!
  #   # current_userが@userでない時はroot_pathなどにリダイレクト
  #   @user = User.find(params[:id])
  #   if @user != current_user
  #     redirect_to root_path
  #   end  
  # end
    
    
end