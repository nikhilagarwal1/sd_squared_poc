class User < ActiveRecord::Base
  has_one :secret_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name
  validates :user_secret_code, presence: true, on: :create
  attr_accessor :user_secret_code
  after_create :set_secret_code
  
  
  def set_secret_code
    sc = SecretCode.find_by(secret_code: user_secret_code)
    sc.update_attributes(user_id: self.id) if sc.present?
  end
  
end