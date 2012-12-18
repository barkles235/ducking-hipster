class Info < ActiveRecord::Base
  attr_accessible :child_of, :text, :title, :topic_id
  belongs_to :topic
end
