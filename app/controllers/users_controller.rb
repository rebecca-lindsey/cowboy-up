class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
        redirect "/users/#{current_user.id}"
    end
    erb :'/users/new'
  end

  post '/signup' do
    u = User.new(email: params["email"], name: params["name"].titleize, password: params["password"])
    if invalid_signup?
      redirect '/signup'
    else
      u.save
      session[:user_id] = u.id
      redirect "/users/#{u.id}"
    end
  end

  get '/login' do
    redirect "/users/#{current_user.id}" if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by_email(params[:email])
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
      @user = User.all.find{|user| user.id.to_s == params[:id]}
      erb :'/users/show'
    end


    private
    def invalid_signup?
      true if u.email.blank? || u.name.blank? || u.password.blank? || User.find_by_email(params["email"]) || !URI::MailTo::EMAIL_REGEXP.match?(params["email"])
    end
end