Rails.application.routes.draw do

  root 'welcome#home'

  get 'welcome/home', to: 'welcome#home'
  get 'welcome/about', to: 'welcome#about'

  get 'pages/home', to: 'pages#home'

end
