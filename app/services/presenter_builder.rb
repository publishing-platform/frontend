class PresenterBuilder
  attr_reader :content_item, :content_item_path, :view_content

  def initialize(content_item, content_item_path, view_context)
    @content_item = content_item
    @content_item_path = content_item_path
    @view_content = view_context
  end

  def presenter
    presenter_name.constantize.new(
      content_item,
      content_item_path,
      view_content,
    )
  end

private

  def presenter_name
    "#{content_item['schema_name'].classify}Presenter"
  end
end
