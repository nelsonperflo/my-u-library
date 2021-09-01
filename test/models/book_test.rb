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

  test "genre should be present" do
    @book.genre = "    "
    assert_not @book.valid?
  end

end
