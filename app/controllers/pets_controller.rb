class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if owner=Owner.find_by_id(params[:pet][:owner_id])
      @pet.owner = owner
    else
      @pet.owner = Owner.create(:name => params[:owner][:name])
    end
    @pet.save
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet_name]
    if params["owner"]["name"].empty?
      @owner = Owner.find(params[:owner_id])
    else 
      @owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.owner = @owner
    @pet.save 
    redirect to "/pets/#{@pet.id}"
  end
end