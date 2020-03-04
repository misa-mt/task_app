# coding: utf-8

User.create!( name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
99.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password)
end

user = User.find(1)

50.times do |i|
  Task.create!( name: "test#{i+1}",
                details: "tesutesu#{i+1}",
                user_id: user.id)
end


user = User.find(2)

50.times do |e|
  Task.create!( name: "test#{e+1}",
                details: "tesutesu#{e+1}",
                user_id: user.id)
end