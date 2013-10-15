SkeletonWithClient::Application.routes.draw do
  scope '/api' do
    resource :session, only: [:create, :destroy]
    resources :users, except: [:new,:edit]
  end
end
