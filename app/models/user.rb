class User < ApplicationRecord
  extend Enumerize

  enumerize :account_type, in: [:standard, :premium], default: :standard
  has_many :boards, dependent: :destroy
  has_many :imports
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]
  has_one_attached :avatar

  validates :avatar, attached: false, content_type: [:png, :jpg, :jpeg], size: { between: 1.kilobyte..5.megabytes}

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.name = (provider_data.info.first_name or provider_data.info.name)
      user.surname = provider_data.info.last_name
      user.image = provider_data.info.image
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # Method to add
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
