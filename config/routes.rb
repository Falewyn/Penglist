PengList::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :playlists, :songs

  #Garde le lien
  get "/mysongs", to: "songs#mysongs"
  get "/myplaylists", to: "playlists#myplaylists"

  #action
  post "/playlists/:id/add_song/:song_id", to: "playlists#add_song", as: :add_song
  post "/playlists/:id/remove_song/:song_id", to: "playlists#remove_song", as: :remove_song
end