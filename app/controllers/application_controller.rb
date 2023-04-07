class ApplicationController < ActionController::Base
  def current_user(id)
    User.find(id)
  end
end
