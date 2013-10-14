SkeletonWithClient::Application.routes.draw do
  scope '/api' do
    devise_for :users,
      controllers: {
        sessions: 'users/sessions'
      },
      path_names: {sign_in: 'sessions', sign_out: 'sessions'}
  end
end
