Rails.application.routes.draw do
  root "productos#index"

  resources :productos
  resources :movimientos, only: [:index, :new, :create]
  resources :clientes
  resources :tasas
  resources :facturas do
    resources :detalle_facturas, only: [:new, :create, :edit, :update, :destroy]
  end
end
