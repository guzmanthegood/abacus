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

    association :author, factory: :user
  end

  factory :task do
    subject     {Faker::Hipster.sentence}
    description {Faker::Hipster.paragraph(3)}
    progress    {[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100].sample}
    task_type   {Task.task_types.values.sample}
    status      {Task.statuses.values.sample}

    association :project, factory: :project
    association :author, factory: :user
  end

  factory :job do
    performed_at  Date.today
    description   {Faker::Hipster.sentence}
    hours         {[0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.25, 3.75, 4.0].sample}

    association :task, factory: :task
    association :user, factory: :user
  end
end