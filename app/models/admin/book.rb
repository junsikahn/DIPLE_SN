class Admin::Book < Standard::Book
  def ordering
    units.unscoped.order(:page, :id).each_with_index do |unit, index|
      unit.subject_id = subject_id
      unit.order = index + 1
      next if unit.new_record?
      unit.save
    end
  end
end
