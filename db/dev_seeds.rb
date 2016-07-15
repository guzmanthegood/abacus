require 'database_cleaner'

Faker::Config.locale = :es
DatabaseCleaner.clean_with :truncation

puts "Creating Users"
User.create(name: 'Carlos Rak', email: 'carlos.rak@gmail.com', password: '123456', password_confirmation: '123456')
User.create(name: 'Carlos Guzmán', email: 'carlos@guzmanweb.com', password: '123456', password_confirmation: '123456')
8.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456')
end

puts "Creating Projects"
10.times do 
  Project.create(name: "#{Faker::App.name} project", web: Faker::Internet.url, description: Faker::Hipster.paragraph(2), author: User.all.sample)
end

puts "Creating Tasks"
Project.all.each do |project|
	[*3..20].sample.times do
		Task.create(	subject: Faker::Hipster.sentence, 
									description: Faker::Hipster.paragraph(3), 
									progress: Faker::Number.between(0, 100), 
									author: User.all.sample, 
									project: project,
									task_type: ['task', 'bug', 'feature'].sample 	)
	end
end
