class UsersController < ApplicationController
  get '/signup' do
    redirect "/users/#{current_user.id}" if logged_in?
    erb :'/users/new'
  end

  post '/signup' do
    @user = User.new(email: params["email"].downcase, name: params["name"].titleize, password: params["password"])
    redirect '/signup' if blank_signup? || invalid_signup?
    @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end

  get '/login' do
    redirect "/users/#{current_user.id}" if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{current_user.id}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.destroy if logged_in?
    redirect to '/'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    redirect_if_not_authorized
    erb :'/users/show'
  end

  delete '/users/:id' do
    @user = User.find(params[:id])
    redirect_if_not_authorized
    @user.destroy
    session.destroy
    redirect to "/"
  end


    private
    def blank_signup?
      true if @user.email.blank? || @user.name.blank? || @user.password.blank?
    end

    def invalid_signup?
      true if User.find_by_email(params["email"].downcase) || !URI::MailTo::EMAIL_REGEXP.match?(params["email"]) || @user.name.length > 35 || @user.password.length < 6
    end

    def redirect_if_not_authorized
      redirect '/login' if !logged_in?
      redirect "/users/#{current_user.id}" if !@user || current_user != @user
    end
end