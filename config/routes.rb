Rails.application.routes.draw do
  resources :organizations do
    resources :contacts
  end
end
