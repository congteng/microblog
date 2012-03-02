FactoryGirl.define do
	factory :user do
		# name 	 "Marshall"
		# email 	 "congteng45@gmail.com"
		# password "123123"

		sequence(:name) {|n| "Person #{n}"}
		sequence(:email){|n| "person_#{n}@123.com"}
		password "123123"

		factory :admin do
			admin true
		end

	end
end