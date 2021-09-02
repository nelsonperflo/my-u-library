require 'test_helper'

class StockTest < ActiveSupport::TestCase
  def setup
    @stock = Stock.new(book:     books(:the_da_vinci_code), 
                       quantity: 1)
  end

  test "should be valid" do
    assert @stock.valid?
  end

  test "quantity should be present" do
    @stock.quantity = "    "
    assert_not @stock.valid?
  end

  test "quantity should be greater than or equal to 0" do
    @stock.quantity = -1
    assert_not @stock.valid?
    @stock.quantity = 0
    assert @stock.valid?
    @stock.quantity = 1
    assert @stock.valid?
  end

  test "available? shoulbe true if quantity > 0" do
    @stock = stocks(:the_da_vinci_code)
    assert_equal @stock.quantity, 1
    assert_equal @stock.available?, true
    @stock.decrease!
    assert_equal @stock.quantity, 0
    assert_equal @stock.available?, false   
  end

  test "decrease quantity" do
    @stock = stocks(:the_da_vinci_code)
    assert_equal @stock.quantity, 1
    @stock.decrease!
    assert @stock.valid?
    assert_equal @stock.quantity, 0
  end

  test "increase quantity" do
    @stock = stocks(:the_da_vinci_code)
    assert_equal @stock.quantity, 1
    @stock.increase!
    assert @stock.valid?
    assert_equal @stock.quantity, 2
  end

end
