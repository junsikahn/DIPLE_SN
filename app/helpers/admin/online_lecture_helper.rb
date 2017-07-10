module Admin::OnlineLectureHelper

  def status(online_lecture)
    if online_lecture.is_completed
      online_lecture.lecture_count > online_lecture.lists.size ? 'negative' : 'positive'
    else
      'warning'
    end
  end

  def status_icon(online_lecture)
    if online_lecture.is_completed
      online_lecture.lecture_count > online_lecture.lists.size ? 'exclamation red' : 'check inverted green'
    else
      'refresh orange'
    end
  end
end
