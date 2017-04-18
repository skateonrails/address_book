Rails.application.routes.draw do
  post 'authentication' => 'authentication#create'

  resources :organizations do
    resources :contacts
  end
end
