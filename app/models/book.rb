class Book < ApplicationRecord

  validates :title, presence: true
  validates :author, presence: true
  validates :published_year, presence: true
  validates :genre, presence: true

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
