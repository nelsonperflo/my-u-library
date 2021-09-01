class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :user

  def Borrowing.search(text)
    if text.present?
      conditions, arguments = [], []
      terms = text.split
      terms.each do |key|
        conditions << "users.first_name ILIKE ? or users.last_name ILIKE ? or users.email ILIKE ?"
        3.times { arguments << "%#{key}%" }
      end
      joins(:user).includes(:book, :user).where([conditions.join(' or '), arguments].flatten)
    else      
      where(nil)
    end
  end

  def not_returned?
    return_date.nil?
  end
end
