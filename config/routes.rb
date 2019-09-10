Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'game_state/:id', to: 'game_state#index'

      post 'endturn', to: 'games#update'

      post 'join_game', to: 'games#join'

      get 'games/:game_id/players/:player_id', to: 'players#show'
    end
  end
end
