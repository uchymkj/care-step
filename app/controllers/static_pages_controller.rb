class StaticPagesController < ApplicationController
  layout "logged_in"

  before_action :require_login
  
  def terms
  end

  def privacy
  end
end
