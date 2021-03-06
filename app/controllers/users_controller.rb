class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect "/tweets"
    end
  end


  post '/signup' do
    if !logged_in? && !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      @user = User.new(username: params[:username],email: params[:email],password: params[:password])
      @user.save
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

 get '/users/:slug' do
   @user = User.find_by_slug(params[:slug])
   erb :'/users/show'
 end


end
