class Search < ActiveRecord::Base

  def search_schools
    schools = School.all

    schools = schools.where(["name LIKE ?","%#{keywords}%"]) if keywords.present?
    schools = schools.where(["scholarship LIKE ?", scholarship]) if scholarship.present?
    schools = schools.where(["rating LIKE ?", rating]) if rating.present?

    return schools

  end
end
