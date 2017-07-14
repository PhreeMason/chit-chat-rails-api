module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_token_user
      logger.add_tags 'ActionCable', "User #{current_user.id}"
    end

    protected 
      def find_token_user
        begin
          token = request.params[:token]
          decoded_token = Auth.decode_token(token)
          user_id = decoded_token[0]["user_id"]
          if current_user = User.find_by(id: user_id)
            current_user
          else
            reject_unauthorized_connection
          end
        rescue
          reject_unauthorized_connection
        end
      end
  end
end