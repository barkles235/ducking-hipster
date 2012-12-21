class Image < ActiveRecord::Base
  attr_accessible :description, :imageable_id, :imageable_type, :name, :pic
  belongs_to :imageable, :polymorphic => true

  has_attached_file :pic, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

end
