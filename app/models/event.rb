class Event < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  validates :start_date, presence: true
  validate :start_date_not_past

  validates :duration, presence: true, numericality: { greater_than: 0 }
  validate :multiple_of_5

  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, inclusion: { in: 0..1000 }
  validates :location, presence: true

  private

  def start_date_not_past
    errors.add(:start_date, "can't be in the past") if start_date.present? && start_date < Time.now
  end

  def multiple_of_5
    errors.add(:duration, "is not a multiple of 5") if duration.present? && (duration % 5 != 0) #si different de 0
  end

  def is_free?
    price == 0
  end
  
end
