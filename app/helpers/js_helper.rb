module JsHelper

  def setup
    return unless user_signed_in?

    javascript_tag <<-END
      User.current = User.parse(#{current_user.to_json});
    END
  end

end