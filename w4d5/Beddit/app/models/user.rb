class User < ActiveRecord::Base
  attr_reader :password

  validates :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

  has_many :subs, dependent: :destroy

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    user && user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def generate_session_token
    token = SecureRandom.base64

    while self.class.exists?(session_token: token)
      token = SecureRandom.base64
    end

    token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end
