# create users


namespace :db do
	desc	"Fill databses with sample data"
	task populate: :environment do
		User.create!(name: "GGGG",
					 email: "GGGG@qq.com",
					 password: "foobar",
					 password_confirmation:  "foobar",
					 admin: true)

		99.times do |n|
			name = Faker::Name.name
			email = "examle#{n*2}@qq.com"
			password = "foobar"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end 
	end
end
