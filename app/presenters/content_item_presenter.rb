class ContentItemPresenter
  include ContentItem::Withdrawable

  attr_reader :content_item,
              :requested_path,
              :view_context,
              :base_path,
              :slug,
              :title,
              :description,
              :schema_name,
              :phase,
              :document_type

  def initialize(content_item, requested_path, view_context)
    @content_item = content_item
    @requested_path = requested_path
    @view_context = view_context
    @base_path = content_item["base_path"]
    @slug = base_path.delete_prefix("/") if base_path
    @title = content_item["title"]
    @description = content_item["description"]
    @schema_name = content_item["schema_name"]
    @phase = content_item["phase"]
    @document_type = content_item["document_type"]
  end

  def parsed_content_item
    content_item.parsed_content
  end

  def parent
    if content_item["links"].include?("parent")
      content_item["links"]["parent"][0]
    end
  end

  def content_id
    content_item["content_id"]
  end

  def web_url
    PublishingPlatformLocation.new.website_root + content_item["base_path"]
  end

  def canonical_url
    web_url
  end

  # The default behaviour to is honour the max_age
  # from the content-store response.
  def cache_control_max_age(_format)
    content_item.cache_control.max_age
  end

  def cache_control_public?
    !content_item.cache_control.private?
  end

  def show_phase_banner?
    phase.in?(%w[alpha beta])
  end

  def show_default_breadcrumbs?
    true
  end

private

  def display_date(timestamp, format = "%-d %B %Y")
    I18n.l(Time.zone.parse(timestamp), format:, locale: "en") if timestamp
  end
end
