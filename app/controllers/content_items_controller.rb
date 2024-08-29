class ContentItemsController < ApplicationController
  rescue_from PublishingPlatformApi::HTTPForbidden, with: :error_403
  rescue_from PublishingPlatformApi::HTTPNotFound, with: :error_notfound
  rescue_from PublishingPlatformApi::HTTPGone, with: :error_410
  rescue_from PublishingPlatformApi::InvalidUrl, with: :error_notfound
  rescue_from ActionView::MissingTemplate, with: :error_406
  rescue_from ActionController::UnknownFormat, with: :error_406  

  attr_accessor :content_item

  def show
    load_content_item
    set_expiry
    render_template
  end

private

  def load_content_item
    content_item = Services.content_store.content_item(content_item_path)

    @content_item = PresenterBuilder.new(
      content_item,
      content_item_path,
      view_context,
    ).presenter
  end

  def render_template
    render @content_item.schema_name
  end  

  def set_expiry
    expires_in(
      @content_item.cache_control_max_age(request.format),
      public: @content_item.cache_control_public?,
    )
  end 
  
  def error_403(exception)
    render plain: exception.message, status: :forbidden
  end

  def error_notfound
    render plain: "Not found", status: :not_found
  end

  def error_406
    render plain: "Not acceptable", status: :not_acceptable
  end

  def error_410
    render plain: "Gone", status: :gone
  end  
end