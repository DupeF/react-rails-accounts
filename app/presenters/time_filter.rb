class TimeFilter

  attr_reader :start_date, :end_date, :scale

  def initialize(start_date, end_date)
    @start_date = start_date.present? ? start_date.to_date : 6.months.ago.beginning_of_month
    @end_date = end_date.present? ? end_date.to_date : Time.now
    set_scale
  end

  def set_scale
    @scale ||= begin
      if duration > 3.years
        :year
      elsif duration > 3.months
        :month
      elsif duration > 3.weeks
        :week
      else
        :day
      end
    end
  end

  def duration
    @duration ||= end_date - start_date
  end

  def steps
    @steps ||= begin
      steps = []
      date = start_date.public_send "beginning_of_#{scale}"
      while date <= end_date do
        steps << date
        date += 1.public_send scale
      end
      steps
    end
  end

  def steps_name
    steps.map{ |date| date_name date }
  end

  def date_name(date)
    case scale
      when :year then date.year
      when :month then date.strftime('%B')
      when :week then I18n.l date.to_date, format: :small
      when :day then I18n.l date.to_date, format: :small
      else ''
    end
  end

  def key_for(date)
    case scale
      when :year then [date.year.to_f]
      when :month then [date.year.to_f, date.month.to_f]
      when :week then [date.year.to_f, date.strftime('%V').to_f]
      when :day then [date.year.to_f, date.month.to_f, date.day.to_f]
      else []
    end
  end

end
