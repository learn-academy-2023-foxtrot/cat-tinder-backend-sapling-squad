## Plant Tinder 

- We added rspec testing in the beginning, while making the rails application.
$ bundle add rspec-rails
$ rails generate rspec:install

- We added a resource: $rails g resource Plant name:string age:integer enjoys:text image:text

- We added seeds into seeds.rb
```rb
plants = [
    {
      name:'Prayer Plant',
      age: 21,
      enjoys:'Enjoys being in direct sunlight between 60 and 72 degrees',
      image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
    },
    {
      name: 'Cactus',
      age: 67,
      enjoys: 'Enjoys desert temperatures of 100 degrees',
      image: 'https://images.unsplash.com/photo-1533066636271-fdbe3e84ad80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FjdHVzfGVufDB8fDB8fHww&auto=format&fit=crop&w=400&q=60'
    },
    {
      name: 'Snake Plant',
      age: 27,
      enjoys: 'Soaking up moisture from the air in direct sunlight',
      image: 'https://images.unsplash.com/photo-1593482892290-f54927ae1bb6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8U25ha2UlMjBwbGFudHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
    }
  ]
```

- As well as a .each to iterate through the array:
```rb
  plants.each do |each_plant|
    Plant.create each_plant
    puts "creating plants #{each_plant}"
  end
```

- We then ran: $rails db:seed to add each entry into the database, so whenever we run the rails console and type in Plant.all, we will see all the entries that we put into the seed.rb file

- We need to enable the controller to accept requests from outside application - The token
```rb
  skip_before_action :verify_authenticity_token
```

- Add cors to the gemfile: 
```rb
gem 'rack-cors', :require => 'rack/cors'
```

- Created a file and added this code: 
```rb 
# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # <- change this to allow requests from any domain while in development.

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

- Done with first backend branch. Finished off with $bundle to update dependencies.

### Added first test to plats_spec.rb
(spec/requests/plants_spec.rb)

```rb
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
```

- Then we added the controller code to make it pass.
(app/controllers/plants_controller.rb)
```rb
 def index
        plants = Plant.all
        render json: plants
    end
```

- Then we addded our seconnd test to plants_spec.rb (spec/requests/plants_spec.rb)
```rb
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
  end
```

- Started working on validations to ensure that user submits name, age, enjoys, and image. 
```rb
RSpec.describe Plant, type: :model do
  it 'should validate name' do
    plant = Plant.create(age: 21, enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees', image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60')
    expect(plant.errors[:name]).to_not be_empty
  end
  it 'should validate age' do
    plant = Plant.create(name: 'Prayer Plant', enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees', image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60')
    expect(plant.errors[:age]).to_not be_empty
  end
  it 'should validate enjoys' do
    plant = Plant.create(name: 'Prayer Plant', age: 21, image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60')
    expect(plant.errors[:enjoys]).to_not be_empty
  end
  it 'should validate image' do
    plant = Plant.create(name: 'Prayer Plant', age: 21, enjoys: 'Enjoys being in direct sunlight between 60 and 72 degrees')
    expect(plant.errors[:image]).to_not be_empty
  end
end

# Then we added it inside the controller
class Plant < ApplicationRecord
    validates :name, :age, :enjoys, :image, presence: true
end
```

- Then added specs to ensure that plant enjoys entry is at least 10 characters long.
```rb
it 'is not valid if enjoys is less than 10 characters' do
  prayer = Plant.create(
    name: 'Prayer Plant',
    age: 21,
    enjoys: 'Sun',
    image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
  )
  expect(prayer.errors[:enjoys]).to_not be_empty
end

  # Then we added to controller!
class Plant < ApplicationRecord
  validates :name, :age, :enjoys, :image, presence: true
  validates :enjoys, length: {minimum: 10}
end
```

- I can add the appropriate request validations to ensure the API is sending useful information to the frontend developer if a new plant is not valid. Inside of spec/requests/plants_spec.rb and also under the POST describe
```rb
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
  
# Then we add the validation into the controller
def create
  plant = Plant.create(plant_params)
  if plant.valid?
    render json: plant
  else
    render json: plant.errors, status: 422
  end
end
```