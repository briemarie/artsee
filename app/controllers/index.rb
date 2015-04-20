#This is the sign-up page
get '/session-viewer' do
  session.inspect
end

get '/' do
  if session[:user_id]
    redirect '/search'
  end

  erb :sign_up
end

post '/' do
  new_user = User.create(email: params[:email], password_hash: params[:password_hash])
  new_user.password = params[:password_hash]
  new_user.save
  session[:user_id] = new_user.id
  if session[:user_id]
    redirect '/search'
  else
    redirect '/'
  end
end


#This is the sign-in page (sessions)
get '/sessions/new' do
  @user = User.find(session[:user_id])

  session[:user_id] = @user.id
  erb :sign_in
end

post '/sessions' do
  @user = User.find(session[:user_id])
  if @user.authenticate?(params[:password_hash])
    session[:user_id] = @user.id
    redirect '/search'
  else
    redirect '/'
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
  redirect '/'
end


#This is the profile/search page
get '/search' do

  erb :profile
end

post '/search' do

  redirect "/#{params[:artist]}"
end

#This is the route for displaying the art from the museum API
get '/:artist' do

  uri = "https://www.brooklynmuseum.org/opencollection/api/?method=collection.search&version=1&format=html&&sort_field=name&image_results_limit=20&api_key=" + "#{ENV['MUSEUM_API_KEY']}" + "&keyword=" + "#{params[:artist]}"

  doc = Nokogiri::HTML(open(uri))
  @art = doc.xpath("//li")
  p uri

  wrapper = Discogs::Wrapper.new("Artsee")
  auth_wrapper = Discogs::Wrapper.new("Artsee", app_key: "MUSIC_API_KEY", app_secret: "MUSIC_SECRET")
  search = auth_wrapper.search("Nirvana", :per_page => 10, :type => :artist)

  p search

  if @art.empty?
    erb :happy
  else
     erb :art
  end
end

#This is the code for looking up music



