class HorsesController < ApplicationController
  get '/horses' do
    redirect_if_not_logged_in
    @users_alpha_sort = User.all_alpha_sort.includes(:horses)
    erb :'/horses/index'
  end

  get '/horses/new' do
    redirect_if_not_logged_in
    @colors = Horse.color_list
    @sexes = Horse.sex_list
    @breeds = Horse.breeds
    erb :'/horses/new'
  end

  post '/horses' do
    redirect_if_not_logged_in
    redirect "/horses/new" if invalid_input? || blank_input? || invalid_name?
    @horse = Horse.new(name: params[:name].titleize, sex: params[:sex], color: params[:color], breed: params[:breed].titleize)
    current_user.horses << @horse
    redirect "users/#{current_user.id}"
  end

  get '/horses/:slug' do
    redirect_if_not_logged_in
    @horse = Horse.find_by_slug(params[:slug])
    redirect_if_no_horse
    erb :'/horses/show'
  end

  get '/horses/:slug/edit' do
    @horse = Horse.find_by_slug(params[:slug])
    redirect_if_not_authorized
    @colors = Horse.color_list
    @breeds = Horse.breeds
    @sexes = Horse.sex_list
    erb :'/horses/edit'
  end

  patch '/horses/:slug' do
    @horse = Horse.find_by_slug(params[:slug])
    binding.pry
    redirect_if_not_authorized
    redirect "/horses/#{params[:slug]}/edit" if invalid_input? || blank_input? || invalid_name?
    @horse.update(name: params[:name], sex: params[:sex], color: params[:color], breed: params[:breed])
    redirect "/horses/#{@horse.slug}"
  end

  delete '/horses/:slug' do
    @horse = Horse.find_by_slug(params[:slug])
    redirect_if_not_authorized
    @horse.destroy
    redirect to "/users/#{current_user.id}"
  end

    private
  def redirect_if_not_logged_in
    redirect '/login' if !logged_in?
  end

  def redirect_if_not_authorized
    redirect '/login' if !logged_in?
    redirect '/horses' if !@horse || current_user != @horse.user
  end

  def redirect_if_no_horse
    redirect "/horses" if !@horse
  end

  def invalid_input?
    true if !Horse.color_list.include?(params[:color]) || !Horse.sex_list.include?(params[:sex]) || params[:name].length > 18 || params[:breed].length > 40
  end

  def blank_input?
    true if params[:name].blank? || params[:sex].blank? || params[:color].blank? || params[:breed].blank?
  end

  def invalid_name?
    true if Horse.find_by(name: params[:name]) && @horse != Horse.find_by(name: params[:name])
  end

end