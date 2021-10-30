class Event < ApplicationRecord
  include GoogleCalendarApi
  has_rich_text :description
  CALENDAR_ID = 'primary'
  belongs_to :user

  validates :title, :description, :venue, :start_date, :end_date, presence: true
  validate :validate_event_dates

  after_create :publish_event_to_gcal
  after_update :update_event_on_gcal
  before_destroy :remove_event_from_gcal
  
  def email_guest_list
    return if self.guest_list.nil?
    
    guest_list.split(", ")
  end

  def validate_event_dates
    return if start_date.nil? || end_date.nil?
    
    if start_date > end_date
      errors.add(:start_date, 'must be less than end date')
    end
  end

  def publish_event_to_gcal
    self.create_google_event(self)
  end

  def update_event_on_gcal
    self.edit_google_event(self)
  end

  def remove_event_from_gcal
    self.delete_google_event(self)
  end
end
