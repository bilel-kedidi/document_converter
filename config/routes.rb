Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  post '/upload_document', to: 'welcome#upload_document'
  get '/download/:key', to: 'welcome#download', as: 'download_file'
end
