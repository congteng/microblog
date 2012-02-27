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

class User < ActiveRecord::Base

	# use for update_attrs method 
	attr_accessible :name, :email, :password, :password_confirmation

	validates :name, presence: true, length: { maximum: 50 }

	valid_email_addr = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: valid_email_addr}, uniqueness: {case_sensitive: false}

	validates :password, length: {minimum: 6}

	has_secure_password

end
