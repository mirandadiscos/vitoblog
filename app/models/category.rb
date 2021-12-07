class Category < ApplicationRecord
    has_many :articles, dependent: :restrict_with_error

    scope :sorted, -> {order(:name) }
    validates :name, presence: true, length: { minimum: 3}
end
