# frozen_string_literal: true

module OauthMocks
  def auth_hash(provider, email)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(
      provider: provider.to_s,
      uid: '123456',
      info: { email: email }
    )
  end
end
