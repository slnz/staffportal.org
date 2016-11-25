class User
  class AsTraineeDecorator < UserDecorator
    decorates_association :logs
    def goal
      object.goal || 4000
    end
  end
end
