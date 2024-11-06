class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   # Associations
   has_many :attendances
   has_many :events, through: :attendances
   has_many :organized_events, class_name: 'Event', foreign_key: 'admin_id'
 
   # Validations
   validates :email, presence: true, uniqueness: true
   validates :encrypted_password, presence: true
   validates :first_name, presence: true
   validates :last_name, presence: true

   after_create :welcome_send
   has_many :organized_events, class_name: 'Event', foreign_key: 'admin_id', dependent: :destroy

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
 
end
