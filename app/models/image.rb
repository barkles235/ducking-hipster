class Image < ActiveRecord::Base
  attr_accessible :description, :imageable_id, :imageable_type, :name, :pic#, :url, :delete_url
  belongs_to :imageable, :polymorphic => true

  has_attached_file :pic, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '800x800>'
  }

  # before_create :default_name
  # def default_name
  #   self.name ||= read_attribute(:pic_file_name)
  # end

  before_create :defaults

  def defaults
    self.name ||= read_attribute(:pic_file_name)
  end

  include Rails.application.routes.url_helpers

  def to_jq_json
    {
      "name" => read_attribute(:pic_file_name),
      "size" => read_attribute(:pic_file_size),
      "url" => pic.url(:original),
      "delete_url" => image_path(self),
      "delete_type" => "DELETE"
    }
  end


# the json we should be getting back:
# delete_type"DELETE"
# delete_url"/uploads/8"
# name"idol2.jpg"
# size51724
# url"/system/uploads/uploads/000/000/008/original/idol2.jpg?1356730287"

end
