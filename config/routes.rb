Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root 'index#index'

  get "/custom_db" ,to: 'create#custom_db', as: 'custom_db'

  get "/custom_img" ,to: 'create#custom_img', as: 'custom_img'

  get "/print_order" ,to: 'print#print_order', as: 'print_order'

  get "/print_quotation" ,to: 'print#print_quotation', as: 'print_quotation'

  get "/create" ,to: 'create#index', as: 'create'

  get "/existed" ,to: 'create#existed', as: 'existed'

  get "/how_to" ,to: 'create#how_to', as: 'how_to'

  get "/test" ,to: 'index#test', as: 'test'

  post "/print_art_work" ,to: 'print#print_art_work', as: 'print_art_work'

  get "/order_make_quotation" ,to: 'admin#order_make_quotation', as: 'order_make_quotation'
  get "/order_make_contact" ,to: 'admin#order_make_contact', as: 'order_make_contact'

  get "/test_pdf" ,to: 'print#test_pdf' ,as: 'test_pdf'

end
