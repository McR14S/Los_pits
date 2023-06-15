Rails.application.routes.draw do
  # Establece la página home como la página principal
  root 'pages#home'

  # Convierte la página home en un recurso
  resources :pages, only: [:index], path: 'home'

  # Reestructura el código como si fueran carpetas
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
  end

  # Servicios
  resources :servicios_auto, only: [:new, :index]
  post '/servicios_auto', to: 'servicios_auto#create'
  get '/obtener_patente', to: 'servicios_auto#obtener_patente'

  get '/perfil', to: 'perfil#show'
  resources :favorites, only: [:index, :create, :destroy], param: :product_id

  # Usuarios
  resources :users, only: [:index, :edit, :update, :destroy], path: '/user', param: :id
  get '/user', to: 'users#index', as: 'user_index'
  # Ruta para actualizar los datos del usuario
  patch '/users/:id', to: 'users#update', as: 'user_update'
  delete '/users/:id', to: 'users#destroy', as: 'user_destroy'

  resources :categories, except: :show

  # Refactorización
  resources :products, path: '/products'

  # Ruta para la página about_us en la carpeta lobby
  get '/about_us', to: 'pages#about_us', as: 'about_us'

  # Vehiculo
  resources :vehiculos, only: [:new]
  post '/vehiculos', to: 'vehiculos#create'

  #pdf
  resources :servicios_auto do
    post :pdf, on: :collection
  end
end
