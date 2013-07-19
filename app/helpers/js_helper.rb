module JsHelper

  def setup
    return unless user_signed_in?

    javascript_tag <<-END
      angular.module('Lunchme').run(function(UserDAO) {
        User.current = UserDAO.findOrInitializeById(#{UserSerializer.new(current_user).to_json});
      });
    END
  end

end