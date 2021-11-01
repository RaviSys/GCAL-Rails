module ApplicationHelper
  def formatted_datetime(datetime)
   datetime.strftime('%d %b %Y %H:%M:%S %p')
  end

  def flash_class(level)
    case level
      when :success then "alert alert-success"
      when :notice then "alert alert-success"
      when :alert then "alert alert-danger"
      when :error then "alert alert-danger"
      when :warning then "alert alert-warning"
    end
  end
end
