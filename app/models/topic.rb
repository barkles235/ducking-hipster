class Topic < ActiveRecord::Base
  attr_accessible :name, :systematic_name
  has_many :infos
end
