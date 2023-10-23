class PlantsController < ApplicationController
    def index
        plants = Plant.all
        render json: plants
    end
    def create
        plant = Plant.create(plant_params)
        if plant.valid?
            render json: plant
        else
            render json: plant.errors, status: 422
        end
    end
    def update 
        plant = Plant.find(params[:id])
        plant.update(plant_params)
        if plant.valid?
            render json: plant
        else 
            render json: plant.errors, status: 422
        end
    end
    def destroy
        plant = Plant.find(params[:id])
        if plant.destroy
            render json: plant
        else 
            render json: plant.errors
        end
    end
    private
    def plant_params
        params.require(:plant).permit(:name, :age, :enjoys, :image) 
    end
end