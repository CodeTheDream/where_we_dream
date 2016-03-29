module ScholarshipsHelper
  def deadline_icon(deadline, size = nil)
    num = if Fixnum === deadline
      deadline
    else
      if deadline > Time.now # future
        case deadline - Time.now
        when 0..1.month; 6
        when 1.month..2.months; 5
        when 2.months..3.months; 4
        when 3.months..4.months; 3
        when 4.months..5.months; 2
        else 1
        end
      else 7 # past
      end
    end
    image_tag "deadline_icon_#{num}.gif", style: "height:#{size || 10}px;"
  end

  def reward(scholarship = nil)
    scholarship = @scholarship unless scholarship
    if scholarship.full_ride
      "Full ride"
    else
      "$" + (number_with_delimiter scholarship.amount)
    end
  end
end
