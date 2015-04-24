class Campaign < ActiveRecord::Base
  belongs_to :user

  has_many :pledges, dependent: :nullify

  validates :title, presence: true
  validates :description, presence: true
  validates :goal, presence: true, numericality: { greater_than_or_equal_to: 10 }

  scope :most_recent, lambda { |x| order("created_at DESC").limit(x) }
end
