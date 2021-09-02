require 'test_helper'

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @borrowing = Borrowing.new(book: books(:the_da_vinci_code), 
                               user: users(:nelson),
                               borrowed_date: Time.zone.now)
  end

  test "should be valid" do
    assert @borrowing.valid?
  end

  test "book id should be present" do
    @borrowing.book_id = "     "
    assert_not @borrowing.valid?
  end

  test "user id should be present" do
    @borrowing.user_id = "     "
    assert_not @borrowing.valid?
  end

  test "borrowed date should be present" do
    @borrowing.borrowed_date = "     "
    assert_not @borrowing.valid?
  end

end
