class User
  class Ability
    include CanCan::Ability

    def initialize(_user)
    end
  end
end
