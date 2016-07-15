FactoryGirl.define do
  factory :user do
    name      						{Faker::Name.name}
    email      						{Faker::Internet.email}
    password 							"123456"
    password_confirmation "123456"
  end

  factory :project do
  	name 					{Faker::App.name}
  	web 					{Faker::Internet.url}
  	description		{Faker::Hipster.paragraph(2)}

  end
end