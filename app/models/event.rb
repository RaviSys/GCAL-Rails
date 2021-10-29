class Event < ApplicationRecord
  include GoogleCalendarApi
  
  CALENDAR_ID = 'primary'
  belongs_to :user

  validates :title, :description, :venue, :start_date, :end_date, presence: true
  validate :validate_event_dates

  def validate_event_dates
    return if start_date.nil? || end_date.nil?
    
    if start_date > end_date
      errors.add(:start_date, 'must be less than end date')
    end
  end
end
