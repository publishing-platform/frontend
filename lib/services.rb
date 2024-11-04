require "publishing_platform_api/content_store"
require "publishing_platform_api/publishing_api"

module Services
  def self.content_store
    @content_store ||= PublishingPlatformApi::ContentStore.new(
      PublishingPlatformLocation.new.find("content-store"),
      # Disable caching to avoid caching a stale max-age in the cache control
      # headers, which would cause this app to set the wrong max-age on its
      # own responses
      disable_cache: true,
    )
  end
end
