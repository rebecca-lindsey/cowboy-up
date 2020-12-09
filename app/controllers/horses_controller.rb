class HorsesController < ApplicationController
    get '/horses' do
        redirect_if_not_logged_in
        @users_alpha_sort = User.all_alpha_sort.includes(:horses)
        erb :'/horses/index'
    end

    get '/horses/new' do
        redirect_if_not_logged_in
        erb :'/horses/new'
    end

    post '/horses' do
        # Fill out with horse creation
    end

    get '/horses/:id' do
        redirect_if_not_logged_in
        @horse = Horse.all.find{|horse| horse.id.to_s == params[:id]}
        erb :'/horses/show' if @horse
    end

    get '/horses/:id/edit' do
        @horse = Horse.all.find{|horse| horse.id.to_s == params[:id]}
        erb :'/horses/edit'
    end

    patch '/horses/:id' do
        # Fill out with horse edit
    end

    delete '/horses/:id' do
        redirect_if_not_logged_in
            @horse = Horse.find_by_id(params[:id])
            if @horse && @horse.user == current_user
                @horse.delete
            end
        redirect to '/horses/index'
    end

    private
  def redirect_if_not_logged_in
    if !logged_in?
      redirect '/login'
    end
  end

end