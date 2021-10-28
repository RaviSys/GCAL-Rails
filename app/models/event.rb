class Event < ApplicationRecord
  include GoogleCalendarApi
  
  CALENDAR_ID = 'primary'
  belongs_to :user
end
