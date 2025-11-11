# db/seeds.rb
require "date"

puts "Seeding demo books…"

demo = [
  { title: "Atomic Habits", author: "James Clear", status: :finished, rating: 5, notes: "Great on systems.", started_on: Date.new(2024,1,5), finished_on: Date.new(2024,1,20) },
  { title: "Clean Code", author: "Robert C. Martin", status: :reading, rating: 4, notes: "Functions & naming are gold.", started_on: Date.today - 14 },
  { title: "The Pragmatic Programmer", author: "Andrew Hunt, David Thomas", status: :wishlist, rating: nil },
  { title: "Deep Work", author: "Cal Newport", status: :finished, rating: 4, started_on: Date.new(2024,3,10), finished_on: Date.new(2024,3,25) },
  { title: "The Lean Startup", author: "Eric Ries", status: :wishlist, rating: nil },
  { title: "Refactoring", author: "Martin Fowler", status: :reading, rating: 5, started_on: Date.today - 7 },
  { title: "Designing Data-Intensive Applications", author: "Martin Kleppmann", status: :wishlist, rating: nil }
]

# Non-destructive: create if missing (same title+author), leave existing records untouched
demo.each do |attrs|
  book = Book.find_or_create_by!(title: attrs[:title], author: attrs[:author])
  if book.created_at == book.updated_at # just created
    book.update!(attrs.except(:title, :author))
  end
end

# A few extra randomized books for pagination & filters (still non-destructive titles)
titles  = ["The Phoenix Project", "Clean Architecture", "You Don't Know JS", "Eloquent Ruby", "Domain-Driven Design"]
authors = ["Gene Kim", "Robert C. Martin", "Kyle Simpson", "Russ Olsen", "Eric Evans"]

3.times do
  title  = titles.sample
  author = authors.sample

  # Skip if we already have this exact pair from above
  next if Book.exists?(title: title, author: author)

  started = [nil, Date.today - rand(10..60)].sample
  finished = started ? (started + rand(3..20)) : nil
  rating = [nil, 2, 3, 4, 5].sample
  status = if finished
             :finished
           elsif started
             :reading
           else
             :wishlist
           end

  Book.create!(
    title: title,
    author: author,
    status: status,
    rating: rating,
    notes: ["", "Worth revisiting", "Recommended"].sample,
    started_on: started,
    finished_on: finished
  )
end

puts "Seed complete. Books count: #{Book.count}"
