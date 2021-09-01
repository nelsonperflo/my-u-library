class Book < ApplicationRecord

  has_one   :stock
  has_many  :borrowings

  validates :title, presence: true
  validates :author, presence: true
  validates :published_year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :genre, presence: true
  validates :copies, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def to_s
    title
  end

  def Book.search(text)    
    if text.present?
      conditions, arguments = [], []
      terms = text.split
      terms.each do |key|
        conditions << "title ILIKE ? or author ILIKE ? or genre ILIKE ?"
        3.times { arguments << "%#{key}%" }
      end
      where([conditions.join(' or '), arguments].flatten)
    else      
      where(nil)
    end
  end

end
