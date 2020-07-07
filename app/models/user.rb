class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name,
            presence: true,
            length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false } # 大文字小文字の区別をしない

  has_secure_password
  validates :password,
            presence: true, # has_secure_passwordの存在性確認は「更新時」には適用してくれないので追記
            length: { minimum: 6 }
end