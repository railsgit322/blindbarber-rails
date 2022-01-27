class HaircutPhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'jpg'

  version :thumbnail do
	resize_to_fit(200, 304)
  end
  
  # def public_id
	# slug = "#{model.id}-#{Time.now.to_i}"
	# slug = slug.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
	# return "haircut-photo-#{slug}"
  # end 

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
	"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{model.filename}"
  end

  
end
