module ApplicationHelper
  def flash_class(level)
    case level
    when 'alert'   then 'alert'     # 흰색
    when 'success' then 'success'   # 녹색
    when 'warning' then 'warning'   # 황색
    when 'error'   then 'error'     # 적색
    when 'notice'  then 'info'      # 청색
    else 'alert'
    end
  end
end
