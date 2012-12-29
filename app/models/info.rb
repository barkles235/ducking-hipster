class Info < ActiveRecord::Base
  attr_accessible :child_of, :text, :title, :topic_id, :relative_layout, :images, :images_attributes
  belongs_to :topic
  has_many :images, :as => :imageable
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => :all_blank

# Extend your custom server-side upload handler to return a JSON response akin to the following output:
# {"files": [
#   {
#     "name": "picture1.jpg",
#     "size": 902604,
#     "url": "http:\/\/example.org\/files\/picture1.jpg",
#     "thumbnail_url": "http:\/\/example.org\/files\/thumbnail\/picture1.jpg",
#     "delete_url": "http:\/\/example.org\/files\/picture1.jpg",
#     "delete_type": "DELETE"
#   },
#   {
#     "name": "picture2.jpg",
#     "size": 841946,
#     "url": "http:\/\/example.org\/files\/picture2.jpg",
#     "thumbnail_url": "http:\/\/example.org\/files\/thumbnail\/picture2.jpg",
#     "delete_url": "http:\/\/example.org\/files\/picture2.jpg",
#     "delete_type": "DELETE"
#   }
# ]}
# Note that the response should always be a JSON object containing a files array even if only one file is uploaded.

  include Rails.application.routes.url_helpers
  def to_jq_upload

    # json = images.each{ |i| i.to_jq_json }
    # return json

  #  images.each{ |i| i.to_json } # behaves the same as above

    json_hash = {}
    image_array = []
    images.each{ |i|
      image_hash = {}
      image_hash["name"] = "test.jpg"
      image_hash["size"] = i.pic.size
      image_hash["url"] = i.pic.url(:original)
      image_array.push(image_hash)
    }
    json_hash["Object"] = image_array

    json_hash.to_json

  end

end
