Faker::Config.locale = :es

puts 'Clearing DataBase'
User.delete_all
Project.delete_all
Task.delete_all

puts 'Creating Users'
User.create(name: 'Carlos Rak', email: 'carlos.rak@gmail.com', password: '123456', password_confirmation: '123456')
User.create(name: 'Carlos Guzmán', email: 'carlos@guzmanweb.com', password: '123456', password_confirmation: '123456')
8.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456')
end

puts 'Creating Projects'
10.times do 
  Project.create(name: "#{Faker::App.name} project", web: Faker::Internet.url, description: Faker::Hipster.paragraph(2), author: User.all.sample)
end

puts 'Creating Tasks'
Project.all.each do |project|
  [*3..20].sample.times do
    Task.create(  subject: Faker::Hipster.sentence,
                  description: Faker::Hipster.paragraph(3),
                  progress: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100].sample,
                  author: User.all.sample,
                  project: project,
                  task_type: Task.task_types.values.sample,
                  status: Task.statuses.values.sample )
  end
end

puts 'Creating jobs'
Task.all.each do |task|
  [*0..5].sample.times do
    Job.create( task: task,
                user: User.all.sample,
                performed_at: Date.today - [*0..15].sample.days,
                description: Faker::Hipster.sentence,
                hours: [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.25, 3.75, 4.0].sample )
  end
end