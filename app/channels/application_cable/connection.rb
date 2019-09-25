module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = find_verified_player
    end

    private

    def find_verified_player
      if verified_player = Player.find(request.params[:player_id])
        verified_player
      end
    end
  end
end
