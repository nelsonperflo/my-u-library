class Role < ApplicationRecord
  has_many :users
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    name.capitalize
  end
end
