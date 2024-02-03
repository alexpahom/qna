module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    attr_reader :warden
    def connect
      self.current_user = env['warden'].user
      @warden = env['warden'] if current_user
    end
  end
end
