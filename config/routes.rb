Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/i18n"
  root "static_pages#i18n"

  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#i18n"
  end
end
