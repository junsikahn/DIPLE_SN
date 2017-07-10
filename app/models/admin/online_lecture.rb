class Admin::OnlineLecture < Standard::OnlineLecture
  after_create :package_check
  after_destroy :package_check

  def package_ids=(package_ids)
    self[:package_ids] = package_ids.gsub(/\s/, '')
  end

  def package_check
    packages = Standard::OnlineLecture.where('package_ids LIKE ?', "%#{uid}%")
    packages.each do |package|
      if package.packages.size == package.package_ids.split(',').size
        package.is_collected = true
      else
        package.is_collected = false
      end
      package.save
    end
  end

  def valid_url?
    uri = URI.parse(uid)
    if uri.class != URI::HTTP
      errors.add(:uid, '유효한 주소 형태가 아닙니다')
    elsif uri.query.nil?
      errors.add(:uid, '파라미터를 포함해주세요')
    else
      domain = PublicSuffix.parse(uri.host).domain
      cgi = CGI.parse(uri.query)
      case domain
      when 'megastudy.net'
        uid = cgi['PKG_CD'].first
        if uid.nil?
          uid      = cgi['CHR_CD'].first
          provider = 1
        else
          provider = 0
        end
      when 'mimacstudy.com'
        uid      = cgi['pid'].first
        provider = 2
      when 'skyedu.com'
        uid      = cgi['code'].first
        provider = 3
      when 'etoos.com'
        uid      = cgi['LECTURE_ID'].first
        provider = 4
      end

      if provider.nil?
        errors.add(:uid, '지원하지 않는 주소입니다')
      elsif uid.nil?
        errors.add(:uid, '필수 파라미터가 누락되었습니다')
      elsif Standard::OnlineLecture.find_by(uid: uid)
        errors.add(:uid, :taken)
      else
        self[:uid] = uid
        self[:online_provider_id] = provider
      end
    end
    errors.blank?
  end

  def parse_lists(subject_id)
    begin
      agent = Mechanize.new do |a|
        a.user_agent_alias = 'Windows IE 10'
      end

      # 검색 페이지로 접근
      search_url =
        case online_provider_id
        when 0 then 'http://www.megastudy.net/teacher_v2/chr/lecture_view_package.asp?PKG_CD='
        when 1 then 'http://www.megastudy.net/lecmain/mains/chr_detail/lecture_detailview.asp?CHR_CD='
        when 2 then 'http://www.mimacstudy.com/tcher/lctr/lctrDetail.ds?pid='
        when 3 then 'http://www.skyedu.com/product/view.asp?code='
        when 4 then 'http://www.etoos.com/lecture/LectureDetail.asp?LECTURE_ID='
        end
      search_url += uid
      page = agent.get(search_url)

      # 강좌 정보
      case online_provider_id
      when 0 # 메가스터디 (패키지)
        self.online_provider_id = 1
        # 파싱 범위 제한
        content = page.css('#container .content_w')
        # 제목
        lecture_title = content.css('#detail_view .info_lecture .info_title').text
        # 강사
        teacher_name = content.css('#detail_view .info_lecture .info_pic strong').text
        teacher_uid = CGI.parse(URI.parse(content.css('#detail_view .info_lecture .info_pic').first['href']).query)['tec_cd'].first
        # 수강대상 / 강의수 / 완강여부
        target_text = ''
        lecture_count = 0
        is_completed = true
        # 패키지목록
        packages = content.css('select#selChrCd option').pluck(:value)
        self.package_ids = packages.join(',')
        self.is_collected = Standard::OnlineLecture.where(uid: packages).size == packages.size
      when 1 # 메가스터디
        # 파싱 범위 제한
        content = page.css('#detail_view')
        # 제목
        lecture_title = content.css('.top_section .cont .txt1').text
        # 강사
        teacher_name = content.css('.top_section .pic strong').text
        teacher_uid = CGI.parse(URI.parse(content.css('.top_section .pic a').first['href']).query)['tec_cd'].first
        # 수강대상 / 강의수
        target_text = ''
        lecture_count = nil
        content.css('.detail_con ul.table li').each do |li|
          target_text = li.children[1].text if li.css('span').first.text == '대상학년'
          lecture_count = li.children[1].text.gsub(/(주\d*회)|(총\d*분)|,|총|강|\/|\s/, '').try(:to_i) if li.css('span').first.text == '강좌구성'
        end
        # 완강여부
        is_completed = false
        content.css('.top_section .cont .icon img').each do |img|
          next unless img['alt'] == '완강된 강좌'
          is_completed = true
        end
        # 강의목록
        content.css('.tab_list .tab03_con table tbody tr td.subject').each_with_index do |item, index|
          next if lists.exists?(order: index)
          lists.build(order: index, title: item.text)
        end
      when 2 # 대성마이맥
        # 파싱 범위 제한
        content = page.css('#lecturedetailDiv')
        # 제목
        lecture_title = content.css('.titarea h3').text
        # 강사
        teacher_name = content.css('.teacher_home span').text
        teacher_uid = CGI.parse(URI.parse(content.css('.teacher_home a').first['href']).query)['tcd'].first
        # 수강대상 / 강의수
        target_text = ''
        lecture_count = nil
        content.css('.mteacherinfo .txtinfo ul li').each do |li|
          target_text = li.children[1].text if li.css('img').first['alt'] == '대상학년 :'
          lecture_count = li.children[1].text.gsub(/강|\/|\s|완강|제작중/, '').try(:to_i) if li.css('img').first['alt'] == '강좌구성 :'
        end
        # 완강여부
        is_package = false
        is_completed = false
        content.css('.iconsarea img').each do |img|
          is_package = true if img['alt'] == '패키지'
          next unless img['alt'] == '완강'
          is_completed = true
        end

        if is_package
          # 패키지목록 (ajax)
          packages = []
          url = URI.encode("http://www.mimacstudy.com/tcher/lctr/pkgInfoList.ds?pid=#{uid}")
          response = RestClient.post url, pid: uid
          lecture_list = JSON.parse(response)['data']
          lecture_list.each do |item|
            packages << item['pid']
          end
          self.package_ids = packages.join(',')
          self.is_collected = Standard::OnlineLecture.where(uid: packages).size == packages.size
        else
          # 강의목록 (ajax)
          url = URI.encode("http://www.mimacstudy.com/tcher/lctr/crclmList.ds?pid=#{uid}")
          response = RestClient.post url, pid: uid
          lecture_list = JSON.parse(response)['data']['crclmList']
          lecture_list.each do |item|
            next if item['crclmNo'] < 0
            next if lists.exists?(order: item['crclmNo'])
            lists.build(order: item['crclmNo'], title: item['mvptName'], time: item['lctrTime'])
          end
        end
      when 3 # 스카이에듀
        # 파싱 범위 제한
        content = page.css('#sky_main_contents')
        # 제목
        lecture_title = content.css('form[name=goods_frm] > table > tr').first.css('td').children.first.text.squish
        # 강사
        teacher_name = '수동으로 입력해주세요'
        teacher_uid = CGI.parse(URI.parse(content.css('.viewTeacherImgSec .teacherImgBtn a').first['href']).query)['teacher_id'].first
        # 수강대상
        target_text = page.css('#header .bi a strong').text
        # 강의수
        content.css('form[name=goods_frm] > table > tr').each do |tr|
          next if tr.css('td.title img').blank? || tr.css('>td.title img').first['alt'] != '강좌구성'
          lecture_count = tr.css('td.value .txt').text.gsub(/총|강|예정|\s/, '').try(:to_i)
        end
        # 완강여부
        is_completed = false
        content.css('form[name=goods_frm] > table > tr').first.css('td').children.css('img').each do |img|
          next unless img['alt'] == '완강'
          is_completed = true
        end
        # 강의목록
        if content.css('.bbsType1').size > 1
          errors.add(:package_ids, '패키지 강의입니다:<br>스카이에듀의 경우에는 수동으로 입력해야 합니다(포함된 강의의 UID를 입력해주세요)'.html_safe)
        elsif content.css('.bbsType1').size == 1
          content.css('.bbsType1 tr:not(.title)').each do |item|
            order = item.css('td')[0].text.try(:to_i)
            next if lists.exists?(order: order)
            lists.build(order: order, title: item.css('td')[1].text, time: item.css('td')[2].text.gsub(/총|분|\s/, '').try(:to_i))
          end
        end
      when 4 # 이투스
        # 파싱 범위 제한
        content = page.css('#Fsub_conbW')
        info = content.css('.info_basic .wr_info')
        # 제목
        lecture_title = info.css('.tit_lect').text.squish
        # 강사
        teacher_name = info.css('.info')[0].css('dd').children.first.text.squish
        teacher_uid = CGI.parse(URI.parse(info.css('.info')[0].css('dd a').first['href']).query)['TEACHER_ID'].first
        # 수강대상 / 강의수
        target_text = ''
        lecture_count = nil
        info.css('dl.info').each do |li|
          target_text = li.css('dd').first.children.first.text if li.css('dt').first.text == '추천대상'
          lecture_count = li.css('dd').first.children.first.text.gsub(/(\d*분씩)|총|,|강|\/|\s/, '').try(:to_i) if li.css('dt').first.text == '강좌구성'
        end
        # 완강여부
        is_package = false
        is_completed = false
        info.css('.wr_ico img').each do |img|
          is_package = true if img['alt'] == '패키지'
          next unless img['alt'] == '완강'
          is_completed = true
        end

        if is_package
          # 패키지목록
          packages = content.css('select.inp_sle option').pluck(:value)
          self.package_ids = packages.join(',')
          self.is_collected = Standard::OnlineLecture.where(uid: packages).size == packages.size
        else
          # 강의목록 (ajax)
          result = agent.get("http://www.etoos.com/Lecture/RDCurriculumListLECTURE_ID_Ajax.asp?LECTURE_ID=#{uid}")
          order = 0
          result.css('table tbody tr:not(.of)').each do |item|
            next if item.css('.tit').size.zero?
            next if lists.exists?(order: order)
            lists.build(order: order, title: item.css('.tit a').first.text.squish, time: item.css('.no_r').text.gsub(/총|분|\s/, '').try(:to_i))
            order += 1
          end
        end
      end

      target_array = []
      target_text.split(/,|·|\s/).each do |text|
        next if text.blank?
        target_array << text.delete(',').delete('·').gsub(/\s/, '')
      end
      target_array.each_with_index do |text, index|
        next if text.include?('고') || text.include?('N')
        target_array[index] = "고#{text.try(:to_i)}"
      end

      self.title = lecture_title
      self.target = target_array.sort.reverse.join('/')
      self.teacher = Standard::OnlineTeacher.find_or_create_by(uid: teacher_uid, online_provider_id: online_provider_id, subject_id: subject_id, name: teacher_name)
      self.lecture_count = lecture_count
      self.is_completed = is_completed
      return true
    rescue
      errors.add(:uid, '오류가 발생했습니다')
      return false
    end
  end
end
