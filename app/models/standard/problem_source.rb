class Standard::ProblemSource < ApplicationRecord
  has_many :problems
  has_many :problem_collections

  before_create :naming

  def naming
    name = []
    name.push("#{year}학년도")
    name.push("#{time == 11 ? '대학수학능력시험' : time + '월'}")
    name.push("#{'수학' + (curriculum == 1 ? '나형' : curriculum == 2 ? '가형' : '공통')}")
    name.push("고#{grade}")
    self[:name] = name.join('_')
  end
end
