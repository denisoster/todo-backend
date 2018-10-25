class Comment < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  belongs_to :task

  validates :description, presence: true
  validates :attachment, length: { maximum: 10.megabytes, message: 'should be less than 10MB' }
  validates :attachment, format: { with: /\.(jpg|png)\Z/i, message: 'should be jpg or png' }
end
