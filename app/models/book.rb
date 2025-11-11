class Book < ApplicationRecord
  enum :status, { wishlist: 0, reading: 1, finished: 2 }

  validates :title,  presence: true
  validates :author, presence: true
  validates :rating, inclusion: { in: 0..5 }, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }

  # Ransack allow-list (Rails 7/8)
  def self.ransackable_attributes(_auth_object = nil)
    %w[
      title author status rating
      started_on finished_on
      created_at updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
