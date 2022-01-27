
class HaircutBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :body, :created_at, :updated_at
  
  fields :front_photo_url, :side_photo_url, :back_photo_url, :misc_photo_url



  
end
