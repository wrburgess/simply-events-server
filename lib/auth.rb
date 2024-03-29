require "jwt"

class Auth
  ALGORITHM = "HS256".freeze

  def self.issue(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    token.strip!
    JWT.decode(token, auth_secret, true, algorithm: ALGORITHM).first
  end

  def self.auth_secret
    ENV["JWT_AUTH_SECRET"]
  end
end
