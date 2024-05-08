class Article < ApplicationRecord
  paginates_per 15
  validates :title, presence: true, length: { minimum: 5 }
  has_many :comments, dependent: :destroy
  # belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    %w(title text)
  end
end
