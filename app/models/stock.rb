class Stock < ApplicationRecord
  belongs_to :book

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def to_s
    quantity
  end

  def available?
    quantity > 0
  end

  def decrease!
    self.quantity -= 1
    self.save!
  end

  def increase!
    self.quantity += 1
    self.save!
  end

end
