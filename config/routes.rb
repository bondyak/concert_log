Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "concerts#index"
  # Routes for the Venue resource:
  # CREATE
  get "/venues/new", :controller => "venues", :action => "new"
  post "/create_venue", :controller => "venues", :action => "create"

  # READ
  get "/venues", :controller => "venues", :action => "index"
  get "/venues/:id", :controller => "venues", :action => "show"

  # UPDATE
  get "/venues/:id/edit", :controller => "venues", :action => "edit"
  post "/update_venue/:id", :controller => "venues", :action => "update"

  # DELETE
  get "/delete_venue/:id", :controller => "venues", :action => "destroy"
  #------------------------------

  # Routes for the Artist resource:
  # CREATE
  get "/artists/new", :controller => "artists", :action => "new"
  post "/create_artist", :controller => "artists", :action => "create"

  # READ
  get "/artists", :controller => "artists", :action => "index"
  get "/artists/:id", :controller => "artists", :action => "show"

  # UPDATE
  get "/artists/:id/edit", :controller => "artists", :action => "edit"
  post "/update_artist/:id", :controller => "artists", :action => "update"

  # DELETE
  get "/delete_artist/:id", :controller => "artists", :action => "destroy"
  #------------------------------

  # Routes for the Concert resource:
  # CREATE
  get "/concerts/new", :controller => "concerts", :action => "new"
  post "/create_concert", :controller => "concerts", :action => "create"

  # READ
  get "/concerts", :controller => "concerts", :action => "index"
  get "/concerts/:id", :controller => "concerts", :action => "show"

  # UPDATE
  get "/concerts/:id/edit", :controller => "concerts", :action => "edit"
  post "/update_concert/:id", :controller => "concerts", :action => "update"

  # DELETE
  get "/delete_concert/:id", :controller => "concerts", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
