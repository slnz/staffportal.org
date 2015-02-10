class User
  class PermissionDecorator < ApplicationDecorator
    decorates_association :user
    decorates_association :account
    decorates_association :by
  end
end
