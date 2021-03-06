class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :title, presence: true
end
