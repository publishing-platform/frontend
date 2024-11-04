module ContentItem
  module Body
    def body
      content_item["details"]["body"].html_safe
    end
  end
end
