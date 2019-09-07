Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'game_state/:id', to: 'game_state#index'
    end
  end
end
