class UsersController < ApplicationController
  
  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/new'
    end
  end
  
  post '/signup' do
    if User.find_by(username: params["username"])
      @user = User.find_by(username: params["username"])
      @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      @user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
      if @user.save && !@user.username.empty? && !@user.email.empty?
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/signup"
      end
    end
  end
  
  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
    end
    redirect '/login'
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
