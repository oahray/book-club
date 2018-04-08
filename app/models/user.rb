class User < ApplicationRecord
  def self.signup(username, email, password)
    create(
      username: username,
      password: password,
      email: email
    )
  end
end
