class User < ActiveRecord::Base
  has_secure_password

  before_save :downcase_email

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true,
            format: {
                with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
            }

  def downcase_email
    self.email = email.downcase
  end
end
