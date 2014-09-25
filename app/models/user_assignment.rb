class UserAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :taskset
  has_attached_file :answer_upload
  do_not_validate_attachment_file_type :answer_upload
end
