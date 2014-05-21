module JsHelper

  def setup
    if user_signed_in?
      javascript_tag <<-END
        window.PusherConfig = {appKey: #{(Pusher.key).to_json}};
        angular.module('Lunchtime').run(function(UserDAO) {
          User.current = UserDAO.findOrInitializeById(#{UserSerializer.new(current_user).to_json});
        });
      END
    else
      javascript_tag <<-END
        window.PusherConfig = {appKey: #{(Pusher.key).to_json}};
      END
    end
  end

end