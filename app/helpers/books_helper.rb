module BooksHelper
  # Returns a Bootstrap badge for the book status
  def status_badge(book)
    label, css = case book.status.to_s
                 when "wishlist" then ["Wishlist", "bg-secondary"]
                 when "reading"  then ["Reading",  "bg-info"]
                 when "finished" then ["Finished", "bg-success"]
                 else [book.status.to_s.humanize, "bg-secondary"]
                 end

    content_tag(:span, label, class: "badge #{css}")
  end

  # Converts a rating (0..5) into stars like ★★★☆☆
  # Accepts either:
  # - a numeric rating (Integer/String)
  # - a Book object (it will use book.rating)
  def star_rating(value)
    value = value.rating if value.respond_to?(:rating)

    return "—" if value.nil?

    # safely cast
    rating = begin
      Integer(value)
    rescue ArgumentError, TypeError
      value.to_i
    end

    rating = 0 if rating < 0
    rating = 5 if rating > 5

    ("★" * rating) + ("☆" * (5 - rating))
  end

  # Backward-compatible helper used in show.html.erb
  def stars_for(value)
    star_rating(value)
  end
end
