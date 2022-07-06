require "application_system_test_case"

class TypesTest < ApplicationSystemTestCase
  setup do
    @type = types(:one)
  end

  test "visiting the index" do
    visit types_url
    assert_selector "h1", text: "Types"
  end

  test "should create type" do
    visit types_url
    click_on "New type"

    fill_in "Name", with: @type.name
    click_on "Create Type"

    assert_text "Type was successfully created"
    click_on "Back"
  end

  test "should update Type" do
    visit type_url(@type)
    click_on "Edit this type", match: :first

    fill_in "Name", with: @type.name
    click_on "Update Type"

    assert_text "Type was successfully updated"
    click_on "Back"
  end

  test "should destroy Type" do
    visit type_url(@type)
    click_on "Destroy this type", match: :first

    assert_text "Type was successfully destroyed"
  end
end
