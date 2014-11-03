class User::AsStatistician < ActiveType::Record[User]
  has_many :gma_memberships
  has_many :gma_organizations, through: :gma_memberships
  has_many :gma_staff_reports
  has_many :gma_measurements, through: :gma_staff_reports

  after_save :gma_update!

  def gma_update!
    return if
      encrypted_password.nil? || gma_update? || !encrypted_password_changed?
    update_column(
      :gma_update, Job::GmaGetUserMeasurements.create(user_id: id)
    )
  end

  def gma_update?
    return false if status.nil?
    return false if status.completed? || status.failed?
    true
  end

  def status
    Resque::Plugins::Status::Hash.get self[:gma_update]
  end
end
