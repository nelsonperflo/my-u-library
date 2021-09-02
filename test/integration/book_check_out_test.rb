require 'test_helper'

class BookCheckOutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:james)
    @book = books(:the_da_vinci_code)
  end

  test "check out book" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'Fargo01$-' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_equal "Hello <strong>James</strong>!!!", flash[:success]
    get book_path(@book)
    assert_response :success
    assert_equal @book.stock.quantity, 1
    patch checkout_book_path(@book)
    assert_redirected_to book_path(@book)
  end
end
