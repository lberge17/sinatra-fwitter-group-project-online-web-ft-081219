require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ftwitter_this_is_a_horrible_secret"
  end
  
  get '/' do
    erb :index
  end

end
