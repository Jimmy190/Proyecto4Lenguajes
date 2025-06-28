Rails.application.routes.draw do
  root "productos#index"

  resources :productos
  resources :movimientos, only: [:index, :new, :create]
  resources :clientes
  resources :tasas
  resources :facturas do
    collection do
      get :preview
    end
  end
end
