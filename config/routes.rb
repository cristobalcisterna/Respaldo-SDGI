Rails.application.routes.draw do
  resources :financial_sources
  resources :investment_types
  resources :condition_goods do
    collection{get '/showrequest' => 'condition_goods#show_request'}
    collection{get '/showexcluded' => 'condition_goods#show_excluded'}
    collection{get '/showlost' => 'condition_goods#show_lost'}
    collection{get '/showdestroyed' => 'condition_goods#show_destroyed'}
    collection{get '/showconditionnull' => 'condition_goods#showcondition_null'}
    collection{get '/showconditionactive' => 'condition_goods#showcondition_active'}
  end
  resources :conditions
  resources :finances
  resources :units
  resources :duty_managers do
    collection{get '/showdutymanagerunit/:id' => 'duty_managers#show_dutymanager_unit'}
  end
  resources :buildings do
    collection{get '/showbuildingunit/:id' => 'buildings#show_building_unit'}
  end
  resources :offices do
    collection{get '/showofficebuilding/:id' => 'offices#show_office_building'}
  end
  resources :goods do 
   collection{get '/shownull' => 'goods#show_null'}
   collection{get '/showactive' => 'goods#show_active'}
   collection{get '/showgoodutymanager/:id' => 'goods#show_good_dutymanager'}
   collection{get '/showgoodoffice/:id' => 'goods#show_good_office'}
   collection{get '/showgoodbuilding/:id' => 'goods#show_good_building'}
   collection{get '/showgoodunit/:id' => 'goods#show_good_unit'}
   collection{get '/showamountgoodutymanager/:id' => 'goods#show_amount_good_dutymanager'}
   collection{get '/showamountgoodoffice/:id' => 'goods#show_amount_good_office'}
  end
  
  #NO DESCOMENTAR, MANEJO INTERNO
  #resources :internal_positions
  #resources :permissions
  root 'welcome#index'
  devise_for :users, skip: [:sessions,:registrations], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end
  #  devise_scope :user do
  #    get 'sign_in', to: 'users/sessions#new', as: :new_session
  #    get 'sign_out', to: 'users/sessions#destroy', as: :destroy_session
  #  end
  #
  # RUTAS DE RESPUESTAS PREDEFINIDAS
  get '/403', to: "errors#authorization_required"
  post '/users/:id/change-profile', to:"profiles#change_user_profile"


 
  #get 'app/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
