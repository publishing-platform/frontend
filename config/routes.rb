Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Static error page routes - in practice used only during deploy, these don't have a
  # published route so can't be accessed from outside
  get "/static-error-pages/:error_code.html", to: "static_error_pages#show"

  get "*path" => "content_items#show"
end
