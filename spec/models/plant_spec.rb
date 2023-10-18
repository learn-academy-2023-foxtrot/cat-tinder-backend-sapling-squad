require 'rails_helper'

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
  it 'is not valid if enjoys is less than 10 characters' do
    prayer = Plant.create(
      name: 'Prayer Plant',
      age: 21,
      enjoys: 'Sun',
      image: 'https://images.unsplash.com/photo-1637967886160-fd78dc3ce3f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByYXllciUyMHBsYW50c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'
    )
    expect(prayer.errors[:enjoys]).to_not be_empty
  end
end
