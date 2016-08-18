Rails.application.routes.draw do

  # testing how to make routes:
  root 'welcome#home'
  get 'welcome/home', to: 'welcome#home'
  get 'welcome/about', to: 'welcome#about'
  get 'pages/home', to: 'pages#home'

  # make all crud routes for articles:
  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

end
