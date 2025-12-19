require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "valid book is valid" do
    book = Book.new(
      title: "Clean Code",
      author: "Robert C. Martin",
      status: :wishlist,
      rating: 5
    )
    assert book.valid?
  end

  test "requires title" do
    book = Book.new(author: "Someone", status: :wishlist)
    assert_not book.valid?
    assert_includes book.errors[:title], "can't be blank"
  end

  test "requires author" do
    book = Book.new(title: "Some Book", status: :wishlist)
    assert_not book.valid?
    assert_includes book.errors[:author], "can't be blank"
  end

  test "rating can be nil" do
    book = Book.new(title: "No Rating", author: "Anon", status: :wishlist, rating: nil)
    assert book.valid?
  end

  test "rating must be between 0 and 5" do
    too_low  = Book.new(title: "Low", author: "A", status: :wishlist, rating: -1)
    too_high = Book.new(title: "High", author: "A", status: :wishlist, rating: 6)

    assert_not too_low.valid?
    assert_not too_high.valid?
  end

  test "status enum accepts wishlist/reading/finished" do
    book = Book.new(title: "Enum", author: "A", status: :reading)
    assert book.valid?
    assert_equal "reading", book.status
  end
end
