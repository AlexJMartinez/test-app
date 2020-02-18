class UsersController < ApplicationController

  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Invalid credentials! Please sign up or try again."
      redirect '/login'
    end
  end


  get "/signup" do
    erb :signup
  end

  post "/users" do
    if params[:user_name] != "" && params[:email] != "" &&  params[:password] != ""
     @user = User.create(params)
     @user.save
     redirect "/users/#{@user.id}"
   else
     redirect '/signup'
  end
end

  get "/users/:id" do
    if !logged_in?
      redirect '/login'
    else
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end
end

  get '/logout' do
    session.clear
    flash[:message] = "See you next time!"
    redirect '/'
  end
end
