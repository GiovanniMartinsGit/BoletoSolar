Rails.application.routes.draw do
  get '/render_pdf', to: 'faturas#render_pdf'

  resources :taxas
  resources :moradores do
    collection do 
      get 'search'
      post 'datatable'
    end
  end

  resources :leituras do
    collection do
      get 'search'
      post 'datatable'
    end
  end

  resources :imoveis do
    collection do
      get 'search'
      post 'datatable'
    end

    member do
      get 'gerar_fatura'
    end

    resources :leituras, only: [:new, :create] do
      collection do
        get 'search'
        post 'datatable'
      end
    end

    resources :faturas, only: [] do
      collection do
        get 'search'
        post 'datatable'
        get 'gerar_fatura'
      end
    end
  end
  
  resources :audits, only: :show
  match '500', :to => 'errors#internal_server_error', :via => :all
  match '422', :to => 'errors#unacceptable', :via => :all
  match '404', :to => 'errors#not_found', :via => :all
  RESPOND_404.map { |r2|  get "/#{r2}", to: redirect("/404") } 
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
