require 'database_cleaner'

Faker::Config.locale = :es
DatabaseCleaner.clean_with :truncation

puts "Creating Users"
User.create(name: 'Carlos Rak', email: 'carlos.rak@gmail.com', password: '123456', password_confirmation: '123456')
User.create(name: 'Carlos Guzmán', email: 'carlos@guzmanweb.com', password: '123456', password_confirmation: '123456')
18.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456')
end

puts "Creating Projects"
20.times do 
  Project.create(name: "#{Faker::App.name} project", web: Faker::Internet.url, description: Faker::Hipster.paragraph(2), author: User.first)
end