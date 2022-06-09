class Import < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :file, attached: true, content_type: [:csv], size: { less_than: 5.megabytes, message: 'is too large' }
end
