class User
  class AsTraineeDecorator < UserDecorator
    decorates_association :logs
    def goal
      3889
    end
  end
end
