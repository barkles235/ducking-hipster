class Post < ActiveRecord::Base
  attr_accessible :body, :user_id
  belongs_to :user

  validates :user_id, presence: true
  validates :body, presence: true


end
