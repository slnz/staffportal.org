# Use this hook to configure merit parameters
Merit.setup do |_config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
[{
  name: :just_registered
}, {
  name: :paperwork_hero,
  custom_fields: { category: :reviews }
}, {
  name: :speedy,
  custom_fields: { category: :reviews }
}].each_with_index do |attrs, index|
  Merit::Badge.create! attrs.merge(id: index)
end
