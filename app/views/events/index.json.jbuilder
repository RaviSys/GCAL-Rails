# json.array! @events, partial: "events/event", as: :event

json.array!(@events) do |event|   
  json.extract! event, :title   
  json.start event.start_date   
  json.end event.end_date   
  json.url event_path(event) 
end