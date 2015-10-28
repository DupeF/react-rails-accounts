class Chart
  attr_reader :time_filter

  def initialize(start_date, end_date)
    @time_filter = TimeFilter.new start_date, end_date
  end

  def chart_type
    raise 'Not Implemented'
  end

  def formatted_data
    raise 'Not Implemented'
  end

  def options
    raise 'Not Implemented'
  end

end