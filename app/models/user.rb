class User < ActiveRecord::Base
	has_many :posts
	has_many :comments, dependent: :destroy

	before_create :set_member

	has_secure_password
	validates_uniqueness_of :email, :username
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

	ROLES = %w[member moderator admin]
	def role?(base_role)
		role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
	end

	private

	def set_member
	  self.role = 'member'
	end 

end
