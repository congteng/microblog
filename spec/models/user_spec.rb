# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do

	before {@user = User.new name:'xx', email: "1@1.com", password: "123123", password_confirmation: "123123"}
	subject{@user}

	it{should respond_to :name}
	it{should respond_to :email}
	it{should respond_to :password_digest}
	it{should respond_to :password}
	it{should respond_to :password_confirmation}
	it{should respond_to :remember_token}

	it{should be_valid}

	it{ should respond_to :authenticate}

	it{should respond_to :admin}
	it{should_not be_admin}

	describe "with admin attribute set to 'true'" do
		before{@user.toggle!(:admin)}
		it{should be_admin}
	end

	describe "remember token" do
		before{@user.save}
		its(:remember_token){should_not be_blank}
	end

	describe "when name is not present" do
		before{@user.name = " "}
 		it{should_not be_valid}
	end

	describe "when name is too long" do
		before{@user.name = "a" * 51}
		it{should_not be_valid}
	end

	describe "when email format is valid" do
		valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
		valid_addresses.each do |addr|
			before{@user.email = addr}
			it{should be_valid}
		end
	end

	describe "when email format is invalid" do
		addr = "aa"
		before{@user.email = addr}
		it{should_not be_valid}
	end


	describe "when email addr is already taken" do
		before do
			user = @user.dup
			user.email = @user.email.upcase
			user.save
			# b = User.new name: "a", email: "a@1.com"
			# c = User.new name: "a", email: "a@1.com"
			# d = User.new name: "a", email: "a@1.com"

			# b.save
			# c.save
			# d.save
		end

		#it{should_not be_valid}
		it{should_not be_valid}
	end

	describe "when password is not present" do
		before{@user.password = @user.password_confirmation = ""}
		it{should_not be_valid}
	end

	describe "when password doesn't match password_confirmation" do
		before{@user.password_confirmation = "zzxczxc"}
		it{should_not be_valid}
	end

	describe "return value of authenticate method" do
		before{@user.save}
		let(:found_user){User.find_by_email @user.email}

		describe "with valid password" do
			it{ should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password){found_user.authenticate "invalid"}

			it{should_not == user_for_invalid_password}
			specify{user_for_invalid_password.should be_false}
		end
	end

	describe "with a password that is too short" do
		before{@user.password = @user.password_confirmation = "a"*5}
		it{should be_invalid}
	end


	describe "return value of authenticate method" do 
		before{@user.save}
		let(:found_user){User.find_by_email @user.email}
		describe "with valid password" do
			it{should == found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do
			let(:user_for_invalid_password){ found_user.authenticate "invalid"}

			it{should_not == user_for_invalid_password}
			specify{user_for_invalid_password.should be_false}
		end
	end

end
