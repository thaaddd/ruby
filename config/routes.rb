Rails.application.routes.draw do
  root to: "agents#random_agent"

  namespace :uploaded_transactions do
    post 'import'
  end

  resources :agents do
    resources :uploaded_transactions
  end
end
