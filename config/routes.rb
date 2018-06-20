Rails.application.routes.draw do
  # Use for login and autorize all resource
  use_doorkeeper do
    # No need to register client application
    skip_controllers :applications, :authorized_applications
  end

  devise_for :users,
             only: [ :sessions, :passwords, :confirmation ],
             skip_helpers: true,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             },
             controllers: {
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               confirmations: 'users/confirmations'
             }
  resources :users do
    member do
      get :activate
    end
  end

  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      devise_for :users, controllers: {
           registrations: 'api/v1/users/registrations',
       }, skip: [:sessions, :password]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :people
      resources :mobile_tokens
      resources :matches do
        collection do
          post :create_decline
          get :next_step
        end
      end
      resources :users do
        collection do
          patch :save_image
          post 'send_recovery_email'
        end
      end
      resources :messages
    end
  end

  root to: 'dashboard#index'
end
