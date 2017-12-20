module UsersHelper
  def age_in_completed_years (bd)
    # Difference in years, less one if you have not had a birthday this year.
    d = Date.today.year
    a = d - bd.year
    a = a - 1 if (
         bd.month >  d.month or
        (bd.month >= d.month and bd.day > d.day)
    )
    a
  end
end
