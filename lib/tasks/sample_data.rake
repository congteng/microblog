namespace :db do
	desc "fill the database with datas"
	task populate: :environment do
		Rake::Task['db:reset'].invoke
		user = User.create!(
			name: 		  "Marshall",
			email: 		  "congteng45@gmail.com",
			password: 	  "123123",
			password_confirmation: "123123")
		user.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = "xxx#{n+1}@123.com"
			password = "123123"
			User.create!(
				name: name, 
				email: email,
				password: password,
				password_confirmation: password)
		end
	end
end
