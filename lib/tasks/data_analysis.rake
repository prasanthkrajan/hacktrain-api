namespace :data_analysis do
  desc "TODO"
  task :run_test => :environment do
    DataAnalysis.instance.log
    session[:object_tree] = "test"
  end
end