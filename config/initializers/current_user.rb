# Assign `current_user` to `Current.user` to access in model class
module Current
  thread_mattr_accessor :user
end
