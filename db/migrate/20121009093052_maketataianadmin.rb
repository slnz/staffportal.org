class Maketataianadmin < ActiveRecord::Migration
  def up
    user = User.where(:email => "tataihono.nikora@studentlife.org.nz").first
    if !user.nil?
      user.admin = "admin"
      user.save
    end
  end
end
