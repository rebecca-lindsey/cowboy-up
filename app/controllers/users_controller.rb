class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
        redirect '/users/:id'
    end
    erb :'/users/new'
  end

  post '/signup' do
    u = User.new(email: params["email"], name: params["name"], password: params["password"])
    if u.email.blank? || u.name.blank? || u.password.blank? || User.find_by_email(params["email"])
            # Invalid signup!
           redirect '/signup'
        else
            # Valid signup
            u.save
            session[:user_id] = u.id
            # Signs in user and sends them to their horses
            redirect '/users/:id'
        end
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    #   if they are logged in, take them to their horses
    end
    erb :'/users/login'
    # Not logged in, show the login form
  end

  post '/login' do
    user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            # if user exists and has valid password
            binding.pry
            session[:user_id] = user.id
            redirect "/users/#{current_user.id}"
        else
            # if invalid login, display error and redirect somewhere
            redirect '/signup'
        end
  end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end

    get '/users/:id' do
        @user = User.all.find{|user| user.id.to_s == params[:id]}
        erb :'/users/show'
    end

end