30.times do
    Course.create!([{
      titulo: Faker::Educator.course_name,
      descricao: Faker::TvShows::GameOfThrones.quote
    }])
  end
