namespace :update do
  desc "TODO"
  task insert_grate_by_year: :environment do
    acedemic_year = AcedemicYear.where(year: "2016").try(:first)
    if acedemic_year.present?
      acedemic_year_last = AcedemicYear.where(year: "2015").try(:first)
      list_grades = acedemic_year_last.grades.map{ |g| {name: g.name, acedemic_year_id: acedemic_year.id} }
      Grade.create(list_grades)
    end
  end

end
