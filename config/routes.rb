Rails.application.routes.draw do
 
  # Establece la página home como la página principal
  root 'pages#home'

  # Convierte la página home en un recurso
  resources :pages, only: [:index], path: 'home'

  #reestructura el codigo como si fueran carpetas --- Ponemos path y as vacios para que solo este nivel codigo
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/'}
  end

  #servicios
  resources :servicios_auto, only: [:new]
  post '/servicios_auto', to: 'servicios_auto#create'
  get '/obtener_patente', to: 'servicios_auto#obtener_patente'

  get '/perfil', to: 'perfil#show'
  resources :favorites, only: [:index, :create, :destroy], param: :product_id
  resources :users, only: :show, path: '/user', param: :username
  resources :categories, except: :show
  #refactor
  resources :products, path: '/products'

  # Ruta para la página about_us en la carpeta lobby
  get '/about_us', to: 'pages#about_us', as: 'about_us'

  #Vehiculo
  resources :vehiculos, only: [:new]
  post '/vehiculos', to: 'vehiculos#create'

end
