class Admin::ProblemSource < ProblemSource
  before_create :naming

  # 파일명
  # 2018_04_경기_학력평가_수학_가형_고3.hwp
  # 표기이름
  # 2018학년도_4월학평(경기)_수학가형_고3

  def year_to_s
    case institute
    when 0 then "#{year}학년도"
    when 1 then "#{year - 1}년도"
    when 2 then "#{year}학년도"
    else        "#{year}년도"
    end
  end

  def time_to_s(abbr = false)
    return '-' unless institute == 0 || institute == 1
    if abbr
      case time
      when 11 then '수능'
      else "#{time}월"
      end
    else
      case time
      when 11 then '대학수학능력시험'
      else
        i = case institute
            when 0 then '모평'
            when 1 then '학평'
            end
        "#{time}월/#{i}(#{location_to_s})"
      end
    end
  end

  def institute_to_s
    case institute
    when 0 then '평가원'
    when 1 then '교육청'
    when 2 then '사관학교'
    when 3 then '경찰대'
    else '기타'
    end
  end

  def location_to_s
    case location
    when 0 then '전국'
    when 1 then '서울'
    when 2 then '경기'
    when 3 then '인천'
    else '기타'
    end
  end

  def subject_to_s
    case subject_id
    when 1 then '국어'
    when 2 then '영어'
    when 3 then '수학'
    else Subject.find(subject_id).name
    end
  end

  def curriculum_to_s(abbr = false)
    return nil unless subject_id == 3
    if abbr
      case curriculum
      when 1 then '문과'
      when 2 then '이과'
      end
    else
      s = case curriculum
          when 1 then '나형'
          when 2 then '가형'
          else        '공통'
          end
      s += curriculum == 1 ? '(A형)' : '(B형)' if year == 2014 || year == 2015
      s
    end
  end

  def grade_to_s
    "고#{grade}"
  end

  def naming
    self[:subject_id] = 3 unless subject_id?
    self[:grade] = 3 unless grade?
    names = []
    names.push(year_to_s)
    names.push(time_to_s)
    names.push(subject_to_s)
    names.push(curriculum_to_s)
    names.push(grade_to_s)
    self[:name] = names.compact.join('_')
  end
end
