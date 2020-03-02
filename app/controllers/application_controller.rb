require './environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get "/" do
    @photo = Photo.all
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
    erb :home
  end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def authorized_to_edit?(photo)
      photo.user == current_user
    end

    def not_logged_in
      if !logged_in?
        redirect '/'
      end
    end
  end
end
