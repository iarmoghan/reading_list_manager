require "test_helper"

class BooksSearchAndPaginationTest < ActionDispatch::IntegrationTest
  setup do
    # Keep tests deterministic
    Book.delete_all
  end

  test "keyword search filters by title or author" do
    Book.create!(title: "Clean Code", author: "Robert C. Martin", status: :wishlist, rating: 5)
    Book.create!(title: "The Hobbit", author: "J.R.R. Tolkien", status: :wishlist, rating: 5)

    get books_url, params: { q: { title_or_author_i_cont: "clean" } }
    assert_response :success

    assert_match "Clean Code", response.body
    assert_no_match "The Hobbit", response.body
  end

  test "status filter works" do
    Book.create!(title: "Book A", author: "A", status: :reading, rating: 4)
    Book.create!(title: "Book B", author: "B", status: :wishlist, rating: 4)

    # IMPORTANT: status is an integer-backed enum, so filter by the integer value
    get books_url, params: { q: { status_eq: Book.statuses[:reading] } }
    assert_response :success

    assert_match "Book A", response.body
    assert_no_match "Book B", response.body
  end

  test "sorting works (title asc)" do
    Book.create!(title: "Zoo", author: "A", status: :wishlist)
    Book.create!(title: "Alpha", author: "B", status: :wishlist)

    get books_url, params: { q: { s: "title asc" } }
    assert_response :success

    body = response.body
    alpha_index = body.index("Alpha")
    zoo_index   = body.index("Zoo")

    assert alpha_index, "Expected 'Alpha' to be present"
    assert zoo_index, "Expected 'Zoo' to be present"
    assert alpha_index < zoo_index, "Expected Alpha to appear before Zoo when sorting title asc"
  end

  test "pagination shows 10 per page (kaminari) and page 2 contains remaining" do
    11.times do |i|
      Book.create!(
        title: format("PageBook %02d", i + 1),
        author: "Tester",
        status: :wishlist
      )
    end

    # Sort title asc for deterministic pagination
    get books_url, params: { q: { s: "title asc" } }
    assert_response :success

    assert_match "PageBook 01", response.body
    assert_match "PageBook 10", response.body
    assert_no_match "PageBook 11", response.body

    get books_url, params: { q: { s: "title asc" }, page: 2 }
    assert_response :success

    assert_match "PageBook 11", response.body
    assert_no_match "PageBook 01", response.body
  end
end
