module TimeFiltersConcern
  extend ActiveSupport::Concern

  included do
    scope :after, -> (date) { where("#{self.table_name}.date >= ?", date) }
    scope :before, -> (date) { where("#{self.table_name}.date <= ?", date) }
    scope :between, -> (start_date, end_date) { after(start_date).before(end_date) }

    scope :with_time_scale, -> (chosen_scale) { public_send "#{chosen_scale}_filtered" }
    scope :year_filtered, -> { group("extract(year from #{self.table_name}.date)")
                                   .order("extract(year from #{self.table_name}.date)") }
    scope :month_filtered, -> { year_filtered.group("extract(month from #{self.table_name}.date)")
                                    .order("extract(month from #{self.table_name}.date)") }
    scope :week_filtered, -> { year_filtered.group("extract(week from #{self.table_name}.date)")
                                   .order("extract(week from #{self.table_name}.date)") }
    scope :day_filtered, -> { month_filtered.group("extract(day from #{self.table_name}.date)")
                                  .order("extract(day from #{self.table_name}.date)") }
  end

end
