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

    check "Active" if @order.active
    fill_in "Customer", with: @order.customer_id
    fill_in "Date", with: @order.date
    fill_in "Guests", with: @order.guests
    fill_in "Observations", with: @order.observations
    fill_in "Table", with: @order.table_id
    fill_in "Tax", with: @order.tax
    fill_in "Tip", with: @order.tip
    fill_in "Total value", with: @order.total_value
    fill_in "User", with: @order.user_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    check "Active" if @order.active
    fill_in "Customer", with: @order.customer_id
    fill_in "Date", with: @order.date
    fill_in "Guests", with: @order.guests
    fill_in "Observations", with: @order.observations
    fill_in "Table", with: @order.table_id
    fill_in "Tax", with: @order.tax
    fill_in "Tip", with: @order.tip
    fill_in "Total value", with: @order.total_value
    fill_in "User", with: @order.user_id
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
