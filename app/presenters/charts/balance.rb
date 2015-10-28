module Charts
  class Balance < Chart

    attr_reader :time_filter, :records, :balance

    def self.for_balance(balance)
      new balance.records.first.date, balance.records.last.date, balance: balance
    end

    def self.for_records(records)
      new records.first.date, records.last.date, records: records
    end

    def initialize(start_date, end_date, args = {})
      super start_date, end_date
      @records = args[:records]
      @balance = args[:balance]
    end

    def chart_type
      'line'
    end

    def formatted_data
      raw_data = balance.records
                     .between(time_filter.start_date, time_filter.end_date)
                     .with_time_scale(time_filter.scale)
                     .sum(:amount)
      data = []
      balance = 0
      time_filter.steps.each do |step|
        balance += (raw_data[time_filter.key_for step] || 0)
        data << balance
      end
      {
          labels: time_filter.steps_name,
          datasets: [
              {
                  label: 'Bought Credits',
                  fillColor: 'rgba(151,187,205,0.2)',
                  strokeColor: 'rgba(151,187,205,1)',
                  pointColor: 'rgba(151,187,205,1)',
                  pointStrokeColor: '#fff',
                  pointHighlightFill: '#fff',
                  pointHighlightStroke: 'rgba(151,187,205,1)',
                  data: data
              }
          ]
      }
    end

    def options
      {}
    end
  end
end
