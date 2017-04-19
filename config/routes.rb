Rails.application.routes.draw do
  apipie
  resources :users, only: [:create] do
    collection do
      post :login
    end
  end

  resources :organizations do
    resources :contacts
  end
end
