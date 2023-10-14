class Question < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_question,
                  against: %i[body]

  validates :body, presence: true, uniqueness: true

  has_many :answers
end
