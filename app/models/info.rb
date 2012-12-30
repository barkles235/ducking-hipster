class Info < ActiveRecord::Base
  attr_accessible :child_of, :text, :title, :topic_id, :relative_layout, :images, :images_attributes
  belongs_to :topic
  has_many :images, :as => :imageable
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => :all_blank

  include Rails.application.routes.url_helpers

  def to_jq_upload
  #  images.each{ |i| i.to_jq_json }
    images.each{ |i| i.as_json(:methods => :url_json) }

    # json = images.each{ |i| i.to_jq_json }
    # return json
    # json =images.each{ |i| i.to_json } # behaves the same as above

    # following does return to broswer, but not in correct JSON format
    # json_hash = {}
    # image_array = []
    # images.each{ |i|
    #   image_hash = {}
    #   image_hash["name"] = "test.jpg"
    #   image_hash["size"] = i.pic.size
    #   image_hash["url"] = i.pic.url(:original)
    #   image_array.push(image_hash)
    # }
    # json_hash["Object"] = image_array
    # json_hash.to_json
  end

end


