class ActivatePremiumAccount
  def initialize(user:)
    @user = user
  end

  def call # rubocop:disable Metrics/AbcSize
    @user.update(account_type: 'premium')
  end
end
