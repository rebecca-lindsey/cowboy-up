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
        if invalid_input? || blank_input? || invalid_name?
            redirect "/horses/new"
        end
        @horse = Horse.new(name: params[:name], sex: params[:sex], color: params[:color], breed: params[:breed])
        redirect_if_not_logged_in
        current_user.horses << @horse
        redirect "users/#{current_user.id}"
    end

    get '/horses/:id' do
        redirect_if_not_logged_in
        @horse = Horse.find_by_id(params[:id])
        redirect_if_no_horse
        erb :'/horses/show'
    end

    get '/horses/:id/edit' do
        @horse = Horse.find_by_id(params[:id])
        redirect_if_not_authorized
        erb :'/horses/edit'
    end

    patch '/horses/:id' do
        @horse = Horse.find_by_id(params[:id])
        redirect_if_not_authorized
        if invalid_input? || blank_input? || invalid_name?
            redirect "/horses/#{params[:id]}/edit"
        else
            @horse.update(name: params[:name], sex: params[:sex], color: params[:color], breed: params[:breed])
            redirect "/horses/#{@horse.id}"
        end
    end

    delete '/horses/:id' do
        @horse = Horse.find_by_id(params[:id])
        redirect_if_not_authorized
        @horse.delete
        redirect to "/users/#{current_user.id}"
    end

    private
  def redirect_if_not_logged_in
    if !logged_in?
      redirect '/login'
    end
  end

    def redirect_if_not_authorized
    if !logged_in?
        redirect '/login'
    elsif !@horse || current_user != @horse.user
        redirect '/horses'
    end
  end

  def redirect_if_no_horse
    if !@horse
        redirect "/horses"
    end
  end

  def invalid_input?
    color_arr = ["Appaloosa", "Bay", "Bay Dapple", "Black", "Brown", "Buckskin", "Champagne", "Chestnut", "Cream", "Dun", "Flaxen Chestnut", "Gray", "Grulla", "Palomino", "Roan", "Silver Dapple", "White"]
    sex_arr = ["Stallion", "Mare", "Gelding"]
    true if !color_arr.include?(params[:color]) || !sex_arr.include?(params[:sex]) || params[:name].length > 18 || params[:breed].length > 40
  end

  def blank_input?
    true if params[:name].blank? || params[:sex].blank? || params[:color].blank? || params[:breed].blank?
  end

  def invalid_name?
    true if Horse.find_by(name: params[:name]) && @horse != Horse.find_by(name: params[:name])
  end

end