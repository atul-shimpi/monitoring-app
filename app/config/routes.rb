Rails.application.routes.draw do
  root 'matrices#index'
  get 'matrices/:host_id/details' => 'matrices#details', as: :host_matrices_details
  get 'matrices/pdf' => 'matrices_pdf#index', as: :host_matrices_pdf
  get 'matrices/:host_id/details/pdf' => 'matrices_details_pdf#details', as: :host_matrices_details_pdf
  get 'matrices/collect' => 'matrices#collect_matrices', as: :collect_matrices_path

  resources :hosts
end
