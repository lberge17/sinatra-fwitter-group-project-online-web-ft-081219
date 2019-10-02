class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params["content"].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params["content"])
      @tweet.user = Helpers.current_user(session)
      @tweet.save
      redirect '/tweets'
    end
  end
  
  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end
  
  post '/tweets/:id/delete' do
    tweet = Tweet.find(params["id"])
    if tweet.user == Helpers.current_user(session)
      tweet.destroy
    end
    redirect '/tweets'
  end
  
  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params["id"])
      if @tweet.user == Helpers.current_user(session)
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params["id"])
    if params["content"].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params["content"])
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
end
