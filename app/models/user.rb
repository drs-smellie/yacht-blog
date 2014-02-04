class User < ActiveRecord::Base
	has_many :posts
	has_many :comments, dependent: :destroy

	has_secure_password
	validates_uniqueness_of :email, :username
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end
