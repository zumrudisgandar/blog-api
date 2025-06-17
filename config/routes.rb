Rails.application.routes.draw do
  resources :comments
  resources :posts
  namespace :api do
    namespace :v1 do
      devise_for :users,
                 controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      },
                 path: '',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'register'
                 }
      resources :posts do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
