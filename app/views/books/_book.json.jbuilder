json.extract! book, :id, :title, :author, :status, :rating, :notes, :started_on, :finished_on, :created_at, :updated_at
json.url book_url(book, format: :json)
