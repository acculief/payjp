Rails.application.routes.draw do

  get 'home/top'
  post '/pay', to: "home#pay"

end
