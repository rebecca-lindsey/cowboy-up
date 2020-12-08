class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
        # Don't let them signup again if logged in
    end
    erb :'/users/new'
  end

  post '/signup' do
    u = User.new(username: params["username"], email: params["email"], password: params["password"])
    if u.username.blank? || u.password.blank? || u.email.blank? || User.find_by_email(params["email"])
            # Invalid signup!
           redirect '/signup'
        else
            # Valid signup
            u.save
            session[:user_id] = u.id
            # Signs in user and sends them to their horses
            redirect '/horses/:id'
        end
  end

  get '/login' do
    if logged_in?
      redirect '/horses/:id'
    #   if they are logged in, take them to their horses
    end
    erb :'/users/login'
    # Not logged in, show the login form
  end

  post '/login' do
    user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            # if user exists and has valid password
            session[:user_id] = user.id
            redirect '/horses/:id'
        # else
            # if invalid login, display error and redirect somewhere
            # redirect '/signup'
        end
  end

    # get '/logout' do
    #     if logged_in?
    #         session.destroy
    #         redirect to '/login'
    #     else
    #         redirect to '/'
    #     end
    # end

    # get '/users/:slug' do
    #     @user = User.all.find{|user| user.slug == params[:slug]}
    #     erb :'/users/show'
    # end

end