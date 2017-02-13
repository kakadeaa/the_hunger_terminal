class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include ActiveModel::Validations

  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  validates_with MobileNoValidator
  validates :name, :mobile_number, :role, :email, presence: true
  validates :mobile_number, length: {is: 13}
  validates_presence_of :company_id, :unless => Proc.new{:role == "super_admin"}
  validates_presence_of :is_active, :if => Proc.new{:role == "employee"}

  belongs_to :company

  before_validation :remove_space
  def remove_space
    if(self.name == nil || self.mobile_number == nil|| self.email == nil)
      return
    end
    self.name = name.squish
    self.mobile_number = mobile_number.squish
    self.email = email.squish
  end

end