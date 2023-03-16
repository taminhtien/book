require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Bank account number", with: @order.bank_account_number
    fill_in "Bank name", with: @order.bank_name
    fill_in "Name", with: @order.name
    fill_in "Phone number", with: @order.phone_number
    fill_in "Quantity", with: @order.quantity
    fill_in "Shipping address", with: @order.shipping_address
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Bank account number", with: @order.bank_account_number
    fill_in "Bank name", with: @order.bank_name
    fill_in "Name", with: @order.name
    fill_in "Phone number", with: @order.phone_number
    fill_in "Quantity", with: @order.quantity
    fill_in "Shipping address", with: @order.shipping_address
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
