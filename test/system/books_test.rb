require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  test "user can create a book from the UI" do
    visit books_url
    click_on "New Book"

    fill_in "Title", with: "System Test Book"
    fill_in "Author", with: "Armoghan"
    select "Wishlist", from: "Status" rescue select "wishlist", from: "Status"

    click_on "Create Book"

    assert_text "System Test Book"
    assert_text "Armoghan"
  end
end
