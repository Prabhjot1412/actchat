class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: -> {request.url == ENV['GOOGLE_AUTH_PATH']}
end
