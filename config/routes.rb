Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # constraints(ip: /120\.142\.\d+\.\d+/) do # 특정 IP주소 외의 접근을 차단함
    namespace :admin do
      resources :problem_collections do
        patch :publish, on: :member
        resources :problems, controller: :problem_collection_problems do
          get :list, on: :collection
        end
        resources :problem_sets, controller: :problem_collection_problem_sets do
          get :list, on: :collection
        end
      end
      resources :problems
      resources :users
      resources :subjects
      # rails g scaffold Admin::User --skip-migration --no-resource-route --template-engine=slim --parent=User
      root 'home#index'
    end
  # end

  scope module: :app do
    resources :home, path: '/', as: :problems
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'app/home#index'
end
