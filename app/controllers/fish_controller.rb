class FishController < ApplicationController

    def index
        fish = Fish.all
        render json: fish
    end
    def create
        fish = Fish.create(fish_params)
        render json: fish
    end
    def update
        fish = Fish.find(params[:id])
        fish.update(fish_params)
        render json: fish
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

