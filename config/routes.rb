Rails.application.routes.draw do
  resources :grant_applications
  mount_devise_token_auth_for 'User', at: 'auth',
                                      controllers: {
                                        sessions: 'devise_token_auth/sessions_wrapper'
                                      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
