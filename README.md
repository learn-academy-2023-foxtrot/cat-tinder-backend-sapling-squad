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

