if Rails.env == 'development'
  Spring.watch 'config/application.yml'
end
