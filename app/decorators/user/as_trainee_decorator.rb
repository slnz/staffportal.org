class User
  class AsTraineeDecorator < UserDecorator
    decorates_association :logs
    def goal
      3850
    end
  end
end
