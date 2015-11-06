module ScholarshipHelper
  def reward(scholarship = nil)
    scholarship = @scholarship unless scholarship
    if scholarship.full_ride
      "Full ride"
    else
      "$" + (number_with_delimiter scholarship.amount)
    end
  end
end
