#User.create!(email: 'admin@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com')

15.times do
    Course.create!([{
      titulo: Faker::Educator.course_name,
      descricao: Faker::TvShows::GameOfThrones.quote,
      user_id: User.first.id,
      linguagens: Faker::ProgrammingLanguage.name, 
      nivel: 'Iniciante'
    }])
  end
