Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create]

  get '/users/:id/groups' => 'users#groups', as: 'user_groups'
  get '/users/:id/events' => 'users#events', as: 'user_events'
  post '/users/:id/events' => 'users#new_event', as: 'user_new_event'

  resources :groups, only: [:show, :create]
  get '/groups/:id/members' => 'groups#members', as: 'group_members'
  post '/groups/:id/members' => 'groups#add_members', as: 'add_group_members'
  get '/groups/:id/events' => 'groups#events', as: 'group_events'

  resources :events, only: [:show]

  resources :invoices, except: [:update, :edit]
end
