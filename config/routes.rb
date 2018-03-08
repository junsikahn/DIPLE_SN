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

  devise_for :users, skip: :all
  devise_scope :user do
    namespace :api do
      get    'api/me',       to: 'api/users/sessions#show'
      post   'api/sign_in',  to: 'api/users/sessions#create'
      delete 'api/sign_out', to: 'api/users/sessions#destroy'
      post   'api/sign_up',  to: 'api/users/registrations#create'
      resources :problems, only: [:index, :show]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  match '*path', to: 'application#index', format: false, via: :get
end
