Rails.application.routes.draw do

  get '/' => 'welcome#index'
  namespace :api do
    namespace :v1 do
      get 'game_state/:id', to: 'game_state#index'

      post 'endturn', to: 'games#update'

      post 'join_game', to: 'games#join'

      get 'games/:game_id/players/:player_id', to: 'players#show'

      post 'games', to: 'games#create'
    end
  end
end
