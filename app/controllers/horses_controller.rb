class HorsesController < ApplicationController
    get '/horses' do
        # Redirect if not logged in
        erb: '/horses/index'
    end

    get '/horses/new' do
        # Redirect if not logged in
        erb: '/horses/new'
    end

    post '/horses' do
        # Fill out with horse creation
    end

    get '/horses/:id' do
        @horse = Horse.all.find{|horse| horse.id.to_s == params[:id]}
        erb :'/horses/show'
    end

    get '/horses/:id/edit' do
        @horse = Horse.all.find{|horse| horse.id.to_s == params[:id]}
        erb :'/horses/edit'
    end

    patch '/horses/:id' do
        # Fill out with horse edit
    end

    delete '/horses/:id' do
        # Fill out with horse delete
    end

end