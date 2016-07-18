class Image < ApplicationRecord
  belongs_to :recipe
  mount_uploader :picture, PictureUploader
end
