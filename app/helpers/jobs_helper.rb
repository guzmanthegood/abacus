module JobsHelper
  def total_hours(jobs)
  	number_with_precision(jobs.inject(0){|s,i| s + i.hours}, precision: 2)
  end
end