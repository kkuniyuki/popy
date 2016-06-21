class MapsController < ApplicationController
    
    def show
      @user = User.find(params[:id])
      # if @user.map_id = nil
      #     @map = Map.new()
      # else
          
      # end
    end
end
