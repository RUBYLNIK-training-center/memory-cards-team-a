class ActivatePremiumAccount
  def initialize(user:)
    @user = user
  end

  def call
    @user.update(account_type: 'premium')
    true
  end
end
