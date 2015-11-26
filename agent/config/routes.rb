Rails.application.routes.draw do
  get 'system/index'
  get 'metrics' => 'metrics#index'
  get 'host/configuration' => 'host_configuration#index'
end
