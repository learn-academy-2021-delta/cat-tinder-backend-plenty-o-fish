require 'rails_helper'

RSpec.describe "Fish", type: :request do
  describe "GET /index" do
    it "gets a list of fish" do
    Fish.create name:'Sparky', age: 5, enjoys: 'licking light sockets'
    get '/fish'
    fish = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(fish.length).to eq 1
   end
  end

  describe "POST /create" do
    it "will create a fish" do

      fish_params = {
        fish: {
          name: 'Scuffle',
          age: 1,
          enjoys: 'Pinching'
        }
      }

      post '/fish', params: fish_params
      expect(response).to have_http_status(200)

      fish = Fish.first
      p fish.id
      expect(fish.name).to eq 'Scuffle'
      expect(fish.age).to eq 1
      expect(fish.enjoys).to eq 'Pinching'
    end
  end

  describe "PATCH /update" do
    it "updates a fish" do
      fish_params = {
        fish: {
          name: 'Diana',
          age: 11,
          enjoys: 'Getting dirty'
        }
      }
      post '/fish', params: fish_params
      fish = Fish.first

      updated_fish_params = {
        fish: {
          name: "Diana",
          age: 33,
          enjoys: 'Getting dirty'
        }
      }
      patch "/fish/#{fish.id}", params: updated_fish_params
      fish = Fish.first
      expect(response).to have_http_status(200)
      expect(fish.age).to eq 33
    end
  end
end   