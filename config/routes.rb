Rails.application.routes.draw do

  scope module: :app do
    resources :mentors, only: [:index, :show]
    # namespace :matches, path: :dashboards, as: :dashboards do
    #   resources :online_lectures
    # end
    resources :dashboards, only: [:index, :show, :update] do
      scope module: :dashboards do
        resources :problem_collection_histories, path: :problem_collections, only: [:index, :new, :create]
        resources :online_lecture_histories, path: :online_lectures, only: [:index, :new, :create, :edit, :update] do
          get :list, on: :collection
          patch :change_period, on: :member
          patch :rating, on: :member
        end
        resources :book_histories, path: :books do
          get :list, on: :collection
          patch :change_period, on: :member
          patch :rating, on: :member
        end
        resources :comments
      end
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  namespace :users do
    resource :verify, only: [:show, :create, :update]
    resource :role, only: [:show, :create, :destroy]
    resource :profile, only: [:show, :edit, :update]

    resource :avatar, only: [:edit, :update]
    resource :introduction, only: [:edit, :update]
    resource :career, only: [:edit, :update] do
      get :preview, on: :collection
    end
    resource :favored_subject, only: [:edit, :update]
    resource :location, only: [:edit, :update] do
      get :address_check, on: :collection
    end
    resource :schedule, only: [:edit, :update]
    resource :bank_info, only: [:edit, :update]

    resource :mentor, only: [:create, :destroy]
  end

  # constraints(ip: /120\.142\.\d+\.\d+/) do # 특정 IP주소 외의 접근을 차단함
    namespace :admin do
      # resources :users
      # resources :mentors
      # resources :mentees
      resources :subjects
      resources :matches, :online_lectures
      resources :universities, :majors, :highschools, :banks
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
      resources :books
      # rails g scaffold Admin::User  --skip-migration --no-resource-route --template-engine=slim --parent=User
      root 'home#index'
    end
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'app/home#index'
end
