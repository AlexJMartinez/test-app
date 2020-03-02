class PhotosController < ApplicationController

  get '/my_photos' do

    if logged_in?
      @photos = Photo.all
      erb :'/photos/user_photos'
    else
      redirect '/login'
    end
  end

  get '/new_photo' do
    erb :'/photos/new_photo'
  end

  post '/new_photo' do
# binding.pry
    if logged_in?
      if params[:name] == "" || params[:img_url] == ""
        flash[:message] = "All fields required!"
        redirect '/new_photo'
      else
        @photo = current_user.photos.build(name: params[:name], img_url: params[:img_url])

        if @photo.save
          redirect "/photos/#{@photo.id}"
        else
          redirect '/new_photo'
          flash[:message] = "Something went wrong."
        end
      end
    else
      redirect '/login'
    end
end

  get '/photos/:id' do
    if logged_in?
      @photo = Photo.find_by_id(params[:id])

      erb :'/photos/show_photo'
    else
      redirect '/login'
  end
end

  get '/photos/:id/edit' do
    set_photo_entry
    not_logged_in
  if authorized_to_edit?(@photo)
    erb :'/photos/edit'
  else
    redirect "users/#{current_user.id}"
  end
end



  patch '/photos/:id' do

    set_photo_entry
      not_logged_in
      if @photo.user == current_user && params[:img_url] != ""
        @photo.update(name: params[:name], img_url: params[:img_url])

        redirect "/photos/#{@photo.id}"
      else
        redirect "users/#{current_user.id}"
      end
  end

  delete '/photos/:id/delete' do

    set_photo_entry
    if authorized_to_edit?(@photo)
    @photo.delete
    redirect to "/"
  end
end

  private

  def set_photo_entry
    @photo = Photo.find(params[:id])
  end

end
