class Question < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_question,
                  against: %i[body],
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :body, presence: true, uniqueness: true

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for  :answers, allow_destroy: true
end
