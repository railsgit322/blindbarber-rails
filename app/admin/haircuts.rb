ActiveAdmin.register Haircut do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :front_photo, :side_photo, :back_photo, :misc_photo, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :front_photo, :side_photo, :back_photo, :misc_photo, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  
  
  menu priority: 2
  permit_params :title, :body, :front_photo

  
  index do
    selectable_column
    column :id
    column :title
    column :body
    column 'Front' do |haircut|
      image_tag(haircut.front_photo.url, height: 60) if haircut.front_photo.present?
    end
    column 'Side' do |haircut|
      image_tag(haircut.side_photo.url, height: 60) if haircut.side_photo.present?
    end
    column 'Back' do |haircut|
      image_tag(haircut.back_photo.url, height: 60) if haircut.back_photo.present?
    end

    actions
  end
  
end
