class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :imports
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
