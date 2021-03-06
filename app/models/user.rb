class User < ApplicationRecord
	has_secure_password
	#has_secure_token :reset_password_token

	validates :email, presence: true, uniqueness: true
	validates :password, length: { minimum: 8 }, if: :password_digest_changed?

	has_many :addresses
	has_many :haircuts, counter_cache: :haircuts_count, dependent: :destroy
	
	mount_uploader :avatar, UserAvatarUploader

	def avatar_url
		avatar.url
	end

	


end
