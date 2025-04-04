module SystemSpecHelper
  def setup_and_visit_content_item(name, overrides = {}, parameter_string = "")
    content_item = PublishingPlatformSchemas::Example.find(name, example_name: name)
    content_item = content_item.deep_merge(overrides)

    stub_content_store_has_item(content_item["base_path"], content_item.to_json)
    visit_with_cachebust("#{content_item['base_path']}#{parameter_string}")
  end

  def visit_with_cachebust(visit_uri)
    uri = Addressable::URI.parse(visit_uri)
    uri.query_values = uri.query_values.yield_self { |values| (values || {}).merge(cachebust: rand) }

    visit(uri)
  end
end
