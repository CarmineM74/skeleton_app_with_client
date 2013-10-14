SkeletonWithClient::Application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: 'users/sessions'
    }
end
