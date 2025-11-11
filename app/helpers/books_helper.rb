module BooksHelper
  def status_badge(book)
    color =
      case book.status
      when "wishlist" then "secondary"
      when "reading"  then "info"
      when "finished" then "success"
      else "secondary"
      end
    content_tag(:span, book.status.titleize, class: "badge bg-#{color}")
  end

  def stars_for(book)
    r = book.rating.to_i
    "★" * r + "☆" * (5 - r)
  end
end
