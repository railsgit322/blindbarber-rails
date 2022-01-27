class Haircut < ApplicationRecord
	
	belongs_to :user, required: true
	
	mount_uploader :front_photo, HaircutPhotoUploader
	mount_uploader :side_photo, HaircutPhotoUploader
	mount_uploader :back_photo, HaircutPhotoUploader
	mount_uploader :misc_photo, HaircutPhotoUploader
	
	
	
	def front_photo_url
		front_photo.url
	end
	
	def side_photo_url
		side_photo.url
	end
	
	def back_photo_url
		back_photo.url
	end
	
	def misc_photo_url
		misc_photo.url
	end

end
