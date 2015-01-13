class User
  class Child < ActiveRecord::Base
    belongs_to :as_contact, class_name: 'User::AsContact'
  end
end
