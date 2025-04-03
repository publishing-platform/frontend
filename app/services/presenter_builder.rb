class PresenterBuilder
  attr_reader :content_item, :content_item_path, :view_content

  def initialize(content_item, content_item_path, view_context)
    @content_item = content_item
    @content_item_path = content_item_path
    @view_content = view_context
  end

  def presenter
    raise SpecialRouteReturned if special_route?
    raise RedirectRouteReturned, content_item if redirect_route?

    presenter_name.constantize.new(
      content_item,
      content_item_path,
      view_content,
    )
  end

private

  def special_route?
    content_item && content_item["document_type"] == "special_route"
  end

  def redirect_route?
    content_item && content_item["schema_name"] == "redirect"
  end

  def presenter_name
    "#{content_item['schema_name'].classify}Presenter"
  end

  class RedirectRouteReturned < StandardError
    attr_reader :content_item

    def initialize(content_item)
      super("Redirect content_item detected")
      @content_item = content_item
    end
  end

  class SpecialRouteReturned < StandardError; end  
end
