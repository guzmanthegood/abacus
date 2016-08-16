module JobsHelper
  def total_hours(jobs)
    hours_str(jobs.inject(0){|s,i| s + i.hours})
  end

  def hours_str(hours)
    number_with_precision(hours, precision: 2, separator: '.')
  end

  def total_hours_str(jobs)
    "Total: #{total_hours(jobs)} horas"
  end
end