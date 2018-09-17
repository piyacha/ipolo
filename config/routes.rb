Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  ActiveAdmin.routes(self)

  resources :designs, only: :index do
    member do
      get "/existed" ,to: 'design#existed', as: 'existed'
      get "/how_to" ,to: 'design#how_to', as: 'how_to'
    end
  end

  root 'index#index'

  get "/print_order" ,to: 'print#print_order', as: 'print_order'

  get "/print_quotation" ,to: 'print#print_quotation', as: 'print_quotation'

  get "/test" ,to: 'index#test', as: 'test'

  post "/print_art_work" ,to: 'print#print_art_work', as: 'print_art_work'

  get "/order_make_quotation" ,to: 'admin#order_make_quotation', as: 'order_make_quotation'
  get "/order_make_contact" ,to: 'admin#order_make_contact', as: 'order_make_contact'

  get "/test_pdf" ,to: 'print#test_pdf' ,as: 'test_pdf'
end
