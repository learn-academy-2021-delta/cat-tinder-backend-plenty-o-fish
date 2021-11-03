require 'rails_helper'

RSpec.describe Fish, type: :model do ##skip the name because we are testing for name
  it 'should have a valid name' do
    fish = Fish.create(age: 6, enjoys: 'Nothing but everything')   
    expect(fish.errors[:name].first).to eq "can't be blank"
  end
  it 'should have a valid age' do #skip age because we are testing for it
    fish = Fish.create(name: 'Split', enjoys: 'Nothing but everything')
    expect(fish.errors[:age].first).to eq "can't be blank"
  end
  it 'should have a valid enjoys' do
    fish = Fish.create(name: 'Split', age: 6)
    expect(fish.errors[:enjoys].first).to eq "can't be blank"
  end
  it 'should have an enjoys entry of at least 10 characters' do
    fish = Fish.create(name: 'Split', age: 6, enjoys: 'nothing')
    expect(fish.errors[:enjoys].first).to eq 'is too short (minimum is 10 characters)'
  end
end
