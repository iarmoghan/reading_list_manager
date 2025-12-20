
demo_books = [
  {
    title: "Clean Code",
    author: "Robert C. Martin",
    status: "finished",
    rating: 5,
    started_on: Date.new(2025, 10, 1),
    finished_on: Date.new(2025, 10, 20),
    notes: "Focus: naming, SRP, refactoring."
  },
  {
    title: "The Pragmatic Programmer",
    author: "Andrew Hunt & David Thomas",
    status: "reading",
    rating: 4,
    started_on: Date.new(2025, 11, 5),
    finished_on: nil,
    notes: "Great practical mindset."
  },
  {
    title: "Design Patterns",
    author: "Gamma, Helm, Johnson, Vlissides",
    status: "wishlist",
    rating: 0,
    started_on: nil,
    finished_on: nil,
    notes: "Classic reference (GoF)."
  },
  {
    title: "Eloquent Ruby",
    author: "Russ Olsen",
    status: "finished",
    rating: 4,
    started_on: Date.new(2025, 9, 10),
    finished_on: Date.new(2025, 9, 28),
    notes: "Ruby idioms and style."
  },
  {
    title: "Refactoring",
    author: "Martin Fowler",
    status: "reading",
    rating: 5,
    started_on: Date.new(2025, 12, 1),
    finished_on: nil,
    notes: "Refactoring patterns + examples."
  }
]

demo_books.each do |attrs|
  key = { title: attrs[:title], author: attrs[:author] }

  book = Book.find_or_initialize_by(key)
  if book.new_record?
    book.assign_attributes(attrs)
    book.save!
  end
end

puts "Seeded/verified #{demo_books.size} demo books."
