require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

module GoogleCalendarApi

  include ActiveSupport::Concern

  def get_google_calendar_client(current_user)
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)

    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        "client_id" => ENV['GOOGLE_CLIENT_ID'],
        "client_secret" => ENV['GOOGLE_CLIENT_SECRET']
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if current_user.expired?
        client.authorization.refresh!
        current_user.update(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      raise e.message
    end
    client
  end

  def create_google_event(event, user)
    client = get_google_calendar_client user
    g_event = get_event(event)
    ge = client.insert_event(Event::CALENDAR_ID, g_event)
    event.update(google_event_id: ge.id)
  end

  def add_quick_google_event(event, user)
    client = get_google_calendar_client user
    ge = client.quick_add_event(Event::CALENDAR_ID, event.title)
    event.update(google_event_id: ge.id)
  end

  def edit_google_event(google_event_id, user, event)
    client = get_google_calendar_client user
    g_event = client.get_event(Event::CALENDAR_ID, google_event_id)
    ge = get_event(event)
    client.update_event(Event::CALENDAR_ID, google_event_id, ge)
  end

  def get_event(event)
    event = Google::Apis::CalendarV3::Event.new({
      summary: event.title,
      location: event.venue,
      description: event.description,
      start: {
        date_time: event.start_date.to_datetime.to_s,
        time_zone: 'Asia/Tokyo', 
      },
      end: {
        date_time: event.end_date.to_datetime.to_s,
        time_zone: 'Asia/Tokyo',
      },
      organizer: {
        email: event.user.email, 
        displayName: event.user.name
      },
      # attendees: event_attendees(event),
      reminders: {
        use_default: false
      }
    })
  end

  def delete_google_event(google_event_id, user)
    client = get_google_calendar_client user
    client.delete_event(Event::CALENDAR_ID, google_event_id)
  end

  def get_google_event(event_id, user)
    client = get_google_calendar_client user
    g_event = client.get_event(Event::CALENDAR_ID, event_id)
  end

  def event_attendees(event)
    event.guests.map {|guest| { email: guest.email }} << { email: event.user.email, displayName: event.user.name, organizer: true }
  end

end
