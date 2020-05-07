class PagesController < ApplicationController
  def landing
    redirect_to photos_path if user_signed_in?
  end
end
