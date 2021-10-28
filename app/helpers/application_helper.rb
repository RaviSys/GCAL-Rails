module ApplicationHelper
  def formatted_datetime(datetime)
    datetime.strftime('%d %b %Y %H:%M:%S %p')
  end
end
