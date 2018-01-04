Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, only: :registrations,
  controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do

    namespace :v1 do
      resources :users
    end

  end

end
