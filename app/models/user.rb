class User < ActiveRecord::Base
  attr_accessible :bio, :name, :password, :password_digest
end
