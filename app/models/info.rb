class Info < ActiveRecord::Base
  attr_accessible :child_of, :text, :title, :topic_id, :relative_layout
  belongs_to :topic
end
