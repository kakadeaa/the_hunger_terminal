class Company < ApplicationRecord
  # include ActiveModel::Validations

  validates_with LandlineValidator
  validates :name, :landline, presence: true
  validates :name, uniqueness:{case_sensitive: false}
  validates :landline, uniqueness: true
  
  validates :landline, length: {is: 12}

  has_one :address, dependent: :destroy, as: :location

  before_validation :remove_space
  def remove_space
    #squish method is not for nil classes
    if(self.name == nil)
      return
    end
    self.name = name.squish
  end
  has_many :users, as: :employees, dependent: :destroy
end