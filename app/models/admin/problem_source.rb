class Admin::ProblemSource < Standard::ProblemSource
  before_create :naming

  # 파일명
  # 2018_04_경기_학력평가_수학_가형_고3.hwp
  # 표기이름
  # 2018학년도_4월학평(경기)_수학가형_고3

  def year_to_s
    case institute
    when 0 then "#{year}학년도"
    when 1 then "#{year}년도"
    end
  end

  def time_to_s
    case time
    when 11 then '대학수학능력시험'
    else
      "#{time}월#{institute_to_s}(#{location_to_s})"
    end
  end

  def institute_to_s
    case institute
    when 0 then '모평'
    when 1 then '학평'
    end
  end

  def location_to_s
    case location
    when 0 then '전국'
    when 1 then '서울'
    when 2 then '경기'
    when 3 then '인천'
    end
  end

  def curriculum_to_s
    if subject_id == 3
      s = case curriculum
          when 1 then '나형'
          when 2 then '가형'
          else        '공통'
          end
      return '수학' + s
    else
      Standard::Subject.find(subject_id).name
    end
  end

  def naming
    self[:subject_id] = 3 unless subject_id?
    self[:grade] = 3 unless grade?
    name = []
    name.push("#{year_to_s}")
    name.push("#{time_to_s}")
    name.push("#{curriculum_to_s}")
    name.push("고#{grade}")
    self[:name] = name.join('_')
  end
end
