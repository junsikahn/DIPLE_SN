class Users::MentorsController < ApplicationController
  # users_mentor_path POST /users/mentors
  def create
    mentor = current_user.mentor
    if current_user.mentor_recognized?
      mentor.recruited_at = Time.now
      mentor.save
      flash[:success] = "#{mentor.user.name} 선생님, 매칭이 신청되었습니다. 빠른 시일 내에 디플의 매니징 티쳐가 #{mentor.user.phone_number} 번으로 연락드리겠습니다."
    else
      flash[:error] = "#{mentor.user.name} 선생님, 프로필을 먼저 작성해주세요"
    end
    redirect_back(fallback_location: root_path)
  end

  # users_mentor_path DELETE /users/mentors
  def destroy
    mentor = current_user.mentor
    mentor.recruited_at = nil
    mentor.save
    flash[:warning] = "#{mentor.user.name} 선생님, 매칭 신청이 취소되었습니다."
    redirect_back(fallback_location: root_path)
  end
end
