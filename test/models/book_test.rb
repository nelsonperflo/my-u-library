require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @book = books(:the_da_vinci_code)
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = "    "
    assert_not @book.valid?
  end

  test "author should be present" do
    @book.author = "    "
    assert_not @book.valid?
  end

  test "published year should be present" do
    @book.published_year = "    "
    assert_not @book.valid?
  end

  test "published year should be greater than 0" do
    @book.published_year = -1
    assert_not @book.valid?
    @book.published_year = 0
    assert_not @book.valid?
    @book.published_year = 2000
    assert @book.valid?
  end

  test "genre should be present" do
    @book.genre = "    "
    assert_not @book.valid?
  end

  test "copies should be present" do
    @book.copies = "    "
    assert_not @book.valid?
  end

  test "copies should be greater than or equal to 0" do
    @book.copies = -1
    assert_not @book.valid?
    @book.copies = 0
    assert @book.valid?
    @book.copies = 1
    assert @book.valid?
  end

end
