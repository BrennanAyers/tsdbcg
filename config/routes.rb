Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'game_state/:id', to: 'game_state#index'

      post 'endturn', to: 'games#update'

      get 'games/:game_id/players/:player_id', to: 'players#show'

      post 'games', to: 'games#new'
    end
  end
end
