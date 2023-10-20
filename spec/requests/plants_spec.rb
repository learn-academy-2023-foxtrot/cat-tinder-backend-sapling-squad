require 'rails_helper'

RSpec.describe "Plants", type: :request do
  describe "GET /index" do
    it "gets a list of plants" do
      Plant.create(
        name: 'Prayer Plant',
        age: 21,
        enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees',
        image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
      )
      get '/plants'

      plant = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(plant.length).to eq 1
    end
  end
  describe "POST /create" do
    it "creates a plant" do
      plant_params = {
        plant: {
          name: 'Prayer Plant',
          age: 21,
          enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees',
          image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
        }
      }
      post '/plants', params: plant_params
      expect(response).to have_http_status(200)
      plant = Plant.first
      expect(plant.name).to eq 'Prayer Plant'
    end
  
    it 'does not create a new plant without a name' do
      plant_params = {
        plant: {
          name: nil,
          age: 21,
          enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees',
          image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
        }
      }
      post '/plants', params: plant_params
      expect(response.status).to eq 422
      plant_error = JSON.parse(response.body)
      expect(plant_error['name']).to include "can't be blank"
    end
  end
  describe "PATCH /update" do
    it "updates a plant" do 
    plant_params = {
      plant: {
        name: 'Pine Tree',
        age: 21,
        enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees',
        image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
      }
    }
    post '/plants', params: plant_params
    plant = Plant.first

      updated_params = {
        plant: {
        name: 'Palm Tree',
        age: 30,
        enjoys: 'Enjoys lots of care',
        image: 'https://images.unsplash.com/photo-1615895963378-661e55f802d1?auto=format&fit=crop&q=60&w=400&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGFsbSUyMHRyZWV8ZW58MHx8MHx8fDA%3D'
      }
    }

    patch "/plants/#{plant.id}", params: updated_params
    updated_plant = Plant.find(plant.id)
    expect(response.status).to eq(200)
    # json = JSON.parse(response.body).deep_symbolize_keys
    plant.reload()
    expect(updated_plant.name).to eq 'Palm Tree'
    expect(updated_plant.age).to eq 30
    expect(updated_plant.enjoys).to eq 'Enjoys lots of care'
    expect(updated_plant.image).to eq 'https://images.unsplash.com/photo-1615895963378-661e55f802d1?auto=format&fit=crop&q=60&w=400&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGFsbSUyMHRyZWV8ZW58MHx8MHx8fDA%3D'
    end
  end
end
