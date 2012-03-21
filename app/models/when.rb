# -*- coding: utf-8 -*-
module When
  DAY = 24*60*60
  
  def when
    ret = ""
    if start_date
      ret += "#{start_date_format(start_date,start_time,end_time)}"
      ret += "#{end_date_format(end_date,end_time,start_date,start_time)}" if end_date || end_time
    elsif end_date
      ret += "#{start_date_format(end_date,end_time,start_time)}"
    else
      ret = "まだ発表されていません"
    end
    ret
  end

  def start
    if start_date||end_date
      ret = (start_date||end_date) + 0.hour
      if start_time
        ret += start_time.hour.hour + start_time.min.minutes
      elsif end_time
        ret += end_time.hour.hour + end_time.min.minutes
      end
    else
      ret = Time.zone.parse("2001-01-01 00:00")
    end
    ret
  end
  
  private
    def days_in_year(d=Date.today)
      return Date.new(d.year+1)-Date.new(d.year) if d < Date.new(d.year,2,28)
      Date.new(d.year+2)-Date.new(d.year+1)
    end
    def days_in_month(d=Date.today)
      (Date.new(d.year,12,31) << (12-d.month)).day
    end
    def day(d); d.day.to_s+"日" end
    def end_date_format(d,t,ref_d,ref_t)
      date = (d || ref_d) + 0.hour
      date += t.hour.hour + t.min.minutes if t
      ref = ref_d + 0.hour
      ref += ref_t.hour.hour + ref_t.min.minutes if ref_t
      ret = ""
      ret += "#{year(d)}" if date-ref >= days_in_year(ref)*DAY
      ret += "#{month(d)}" if date-ref >= days_in_month(ref)*DAY
      if date-ref >= DAY
        ret += "#{day(d)}"
        ret += " " if t
      end
      ret += time(t) if t && ref_t
      ret = "-"+ret unless ret.blank?
      ret
    end
    def month(d); d.month.to_s+"月" end #I18n.t('date.abbr_month_names')[month_no(d)] end
    def start_date_format(d,t1,t2)
      ret = ""
      ret += year(d) if Date.today.year != d.year
      ret += "#{month(d)}#{day(d)}"
      if t1
        ret += " #{time(t1)}"
      elsif t2
        ret += " #{time(t2)}"
      end
      ret
    end
    def time(t); t.strftime("%H:%M") end
    def year(d); d.year.to_s+"年" end
end
