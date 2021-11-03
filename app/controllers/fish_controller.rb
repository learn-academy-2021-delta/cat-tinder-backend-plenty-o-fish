class FishController < ApplicationController
#Anything to do with the controller is a spec/request
    def index
        fish = Fish.all
        render json: fish
    end

    def create
        fish = Fish.create(fish_params)
        if fish.valid?
            render json: fish
        else 
            render json: fish.errors, status: 422
        end
    end

    def update
        fish = Fish.find(params[:id])
        fish.update(fish_params)
        if fish.valid?
          render json: fish
        else 
          render json: fish.errors, status: 422
    end
  end

    def destroy
        fish = Fish.find(params[:id])
        fish.destroy
        render json: fish
    end
    
      private
      def fish_params
        params.require(:fish).permit(:name, :age, :enjoys)
      end
    
 end