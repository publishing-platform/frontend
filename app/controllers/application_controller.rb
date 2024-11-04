class ApplicationController < ActionController::Base
private

  def content_item_path
    "/#{URI.encode_www_form_component(params[:path]).gsub('%2F', '/')}"
  end
end
