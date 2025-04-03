module PresenterHelper
  def create_presenter(presenter_class,
                       content_item: schema_item("answer"),
                       requested_path: "/test-content-item",
                       view_context: ApplicationController.new.view_context)
    presenter_class.new(content_item, requested_path, view_context)
  end

  def presented_item(schema = schema_name, overrides = {})
    example = schema_item(schema)
    present_example(example.merge(overrides))
  end

  def present_example(example)
    create_presenter(
      "#{schema_name.classify}Presenter".safe_constantize,
      content_item: example,
    )
  end

  def schema_item(schema = schema_name, example_name = schema_name)
    PublishingPlatformSchemas::Example.find(schema, example_name:)
  end
end