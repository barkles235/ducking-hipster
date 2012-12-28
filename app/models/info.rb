class Info < ActiveRecord::Base
  attr_accessible :child_of, :text, :title, :topic_id, :relative_layout, :images, :images_attributes
  belongs_to :topic
  has_many :images, :as => :imageable
  accepts_nested_attributes_for :images, :reject_if => :all_blank
  resourcify
end
