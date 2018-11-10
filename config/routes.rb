HacktrainApi::Application.routes.draw do
  post '/motion_data/retrieve' => 'motion_data#retrieve' 
end
