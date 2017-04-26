class SecretCode < ActiveRecord::Base
  belongs_to :user
  attr_accessor :frequency
  scope :active_secret_codes, -> {where("user_id IS NULL") }
  
  def self.generate_code
    code = SecureRandom.urlsafe_base64(4)
    if SecretCode.where(secret_code: code).present?
      generate_code
    end
    return code
  end

end
