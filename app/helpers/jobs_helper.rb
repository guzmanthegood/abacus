module JobsHelper
  def total_hours(jobs)
  	number_with_precision(jobs.inject(0){|s,i| s + i.hours}, precision: 2, separator: '.')
  end

  def total_hours_str(jobs)
    "Total: #{total_hours(jobs)} horas"
  end
end