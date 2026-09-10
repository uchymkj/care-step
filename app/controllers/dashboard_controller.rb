class DashboardController < ApplicationController
  layout "logged_in"
  
  before_action :require_login
  
  def index
  end
end
