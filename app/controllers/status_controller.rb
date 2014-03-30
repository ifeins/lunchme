class StatusController < ApplicationController

  def ping
    render nothing: true
  end

end