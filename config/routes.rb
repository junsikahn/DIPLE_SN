Rails.application.routes.draw do
  # constraints(ip: /120\.142\.\d+\.\d+/) do # 특정 IP주소 외의 접근을 차단함
    namespace :admin do
      resources :problem_collections do
        patch :publish, on: :member
        resources :problems, controller: :problem_collection_problems
        resources :problem_sets, controller: :problem_collection_problem_sets
      end
      resources :problem_sources do
        post :preview, on: :collection
      end
      resources :problems do
        get :source, on: :collection
        get :list, on: :collection
      end
      resources :problem_images, only: [:show, :create]
      resources :problem_tags do
        get :search, on: :collection
      end
      resources :subjects

      resources :users do
        get :report, on: :collection
        get :report_user, on: :member
      end
      # rails g scaffold Admin::User --skip-migration --no-resource-route --template-engine=slim --parent=User
      root 'home#index'
    end
  # end

  devise_scope :user do
    namespace :api do
      get    'me',       to: 'users/sessions#show'
      post   'sign_in',  to: 'users/sessions#create'
      delete 'sign_out', to: 'users/sessions#destroy'
      post   'sign_up',  to: 'users/registrations#create'
      resources :problems, only: [:index, :show]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  match '*path', to: 'application#index', format: false, via: :get
end
