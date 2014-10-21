SimpleCov.adapters.define 'pocketchange' do
  
  # Lib
  %w(quiet_assets pry memcache email).each do |file|
    add_filter "/config\/initializers\/#{file}.rb"
  end
  
  # Initializers
  %w(populator method_cache functor models/list).each do |file|
    add_filter "/lib\/#{file}.rb"
  end
  
  # Tests
  %w(functional factories).each do |dir|
    add_filter "/test\/#{dir}/"
  end
  
  add_group "Model",  "redshift/model"
  add_group "Tasks",  "redshift/steps"
  add_group 'API',    "app/controllers/api"
  add_group 'Admin',  "app/controllers/admin"
  add_group 'Dashboard',    "app/controllers/dashboard"
  add_group 'Store',        "app/controllers/store"
  add_group 'Recent' do |source|
    changes = `find lib -maxdepth 5 -mtime -1 -ls`
    changes.include?(source.filename)
  end
  add_group "Bad" do |source|
    source.covered_percent < 80
  end
end
