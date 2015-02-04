class UserObserver < ActiveRecord::Observer
  def before_validation(user)
    return if user.password.blank?
    response = HTTParty.post('https://thekey.me/cas/v1/tickets',
                             body: { username: user.email,
                                     password: user.password })
    return if response.code == 201
    user.errors.add(:password, 'Incorrect Password')
  rescue OpenSSL::Cipher::CipherError
    user.password = nil
    user.save
  end
end
