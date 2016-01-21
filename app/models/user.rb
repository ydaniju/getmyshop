class User < ActiveRecord::Base
  has_many :oauth_accounts

  before_create :assign_token

  def assign_token
    self.active_status = false
    self.activation_token = [*"0".."9", *"a".."z", *"A".."Z"].sample(50).join
  end
end