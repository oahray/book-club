class SessionsController < ApplicationController
  def index
  end

  def login
    User.signup(
      username: param[:username],
      email: param[:email],
      password: param[:password]
    )
  end
end