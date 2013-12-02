# create users


namespace :db do
	desc	"Fill databses with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end

	def make_users
		User.create!(name: "GGGG",
					 email: "GGGG@qq.com",
					 password: "foobar",
					 password_confirmation:  "foobar",
					 admin: true)

		99.times do |n|
			name     = Faker::Name.name
			email    = "examle#{n*2}@qq.com"
			password = "foobar"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end 
    end
		
	def make_microposts
	    users = User.all(limit: 50)
        50.times do
      	    content = Faker::Lorem.sentence(5)
        	users.each { |user| user.microposts.create!(content: content) }
       end
	end

	def make_relationships
		users          = User.all
		user           = users.first
		followed_users = users[2..50]
		followers      = users[3..40]
		followed_users.each  { |followed|  user.follow!(followed) }
		followers.each  { |follower| follower.follow!(user)}
		
	end

end























