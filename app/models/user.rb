
class User < ActiveRecord::Base
  attr_reader :password
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 2, allow_nil: true}

  has_many :subs,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Sub

  has_many :posts,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: :Post

  has_many :comments, as: :commentable

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)

    return @user if @user && @user.is_password?(password)
    nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
