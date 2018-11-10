HacktrainApi::Application.routes.draw do 
  namespace :api do 
    namespace :v1 do 
      get '/motion_data/retrieve' => 'motion_data#retrieve'
    end
  end
end
