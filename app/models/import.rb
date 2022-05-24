class Import < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :file, attached: true, content_type: [:csv]
end
