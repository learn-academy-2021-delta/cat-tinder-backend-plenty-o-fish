require 'rails_helper'

RSpec.describe "Fish", type: :request do
  describe "GET /index" do
    it 'gets a list of fish' do
    Fish.create name:'Sparky', age: 5, enjoys: 'licking light sockets'
    get '/fish'
    fish = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(fish.length).to eq 1
    end
  end

  describe "POST /create" do
    it 'will create a fish' do

      fish_params = {
        fish: {
          name: 'Scuffle',
          age: 1,
          enjoys: 'Pinching everything'
        }
      }

      post '/fish', params: fish_params
      expect(response).to have_http_status(200)

      fish = Fish.first
      p fish.id
      expect(fish.name).to eq 'Scuffle'
      expect(fish.age).to eq 1
      expect(fish.enjoys).to eq 'Pinching everything'
    end
  end

  describe "PATCH /update" do
    it 'updates a fish' do
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
          name: 'Diana',
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
    describe "DELETE /destroy" do
      it 'deletes a fish' do
        fish_params = {
          fish: {
            name: 'Snooky',
            age: 44,
            enjoys: 'Raging on the Jersey Shore' 
          }
        }
            post '/fish', params: fish_params
          fish = Fish.first
          delete "/fish/#{fish.id}"
          expect(response).to have_http_status(200)
          fish = Fish.all
          expect(fish).to be_empty
          end
        end

        describe 'fish validation error codes' do
          it 'does not create a fish with a name' do
            fish_params = {#leave name out to test name
              fish: {
                age: 2,
                enjoys: 'Raging on the Jersey Shore'
              }
            }
            post '/fish', params: fish_params
            expect(response).to have_http_status(422)
            fish = JSON.parse(response.body)
            expect(fish['name']).to include "can't be blank"
          end
          it 'does not create a fish with an age' do
            fish_params = {#leave age out to test age
              fish: {
                name: 'Snooky',
                enjoys: 'Raging on the Jersey Shore'
              }
            }
            post '/fish', params: fish_params
            expect(response).to have_http_status(422)
            fish = JSON.parse(response.body)
            expect(fish['age']).to include "can't be blank"
          end
          it 'does not create a fish with an enjoys' do
            fish_params = {#leave enjoys out to test enjoys
              fish: {
                name: 'Snooky',
                age: 3
              }
            }
            post '/fish', params: fish_params
            expect(response).to have_http_status(422)
            fish = JSON.parse(response.body)
            expect(fish['enjoys']).to include "can't be blank"
          end
        end
      describe "cannot update a fish without valid attributes" do
          it 'cannot update a fish without a name' do
            fish_params = {
              fish: {
                name: 'Nala',
                age: 2,
                enjoys: 'Big squuezes'
              }
            }
            post '/fish', params: fish_params
            fish = Fish.first
            fish_params = {
              fish: {
                name: '',
                age: 2,
                enjoys: 'Big squuezes'
              }
            }
            patch "/fish/#{fish.id}", params: fish_params
            fish = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(fish['name']).to include "can't be blank"
          end
          it 'cannot update a fish without a age' do
            fish_params = {
              fish: {
                name: 'Nala',
                age: 4,
                enjoys: 'Tight squeezes'
              }
            }
            post '/fish', params: fish_params
            fish = Fish.first
            fish_params = {
              fish: {
                name: 'Nala',
                age: '',
                enjoys: 'Big squuezes'
              }
            }
            patch "/fish/#{fish.id}", params: fish_params
            fish = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(fish['age']).to include "can't be blank"
          end
          it 'cannot update a fish without an enjoys' do
            fish_params = {
              fish: {
                name: 'Nala',
                age: 4,
                enjoys: 'Big squuezes'
              }
            }
            post '/fish', params: fish_params
            fish = Fish.first
            fish_params = {
              fish: {
                name: 'Nala',
                age: 4,
                enjoys: '',
              }
            }
            patch "/fish/#{fish.id}", params: fish_params
            fish = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(fish['enjoys']).to include "can't be blank"
          end
          it 'cannot update a fish without an enjoys that is at least 10 characters' do
            fish_params = {
              fish: {
                name: 'Nala',
                age: 4,
                enjoys: 'Big squuezes'
              }
            }
            post '/fish', params: fish_params
            fish = Fish.first
            fish_params = {
              fish: {
                name: 'Nala',
                age: 4,
                enjoys: 'cuddles'
              }
            }
            patch "/fish/#{fish.id}", params: fish_params
            fish = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(fish['enjoys']).to include 'is too short (minimum is 10 characters)'
          end
        end
      end          
       