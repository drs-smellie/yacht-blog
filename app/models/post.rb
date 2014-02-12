class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates 	:title, length: { minimum: 3 }, presence: true
	validates :text, length: { minimum: 10 }, presence: true
	validates :user, presence: true

end
