ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :first_name, :last_name, :email, :avatar, :phone
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :avatar, :phone]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  
  menu priority: 1
  permit_params :first_name, :last_name, :avatar, :email
  filter :first_name
  filter :last_name
  filter :email
  
  index do
    selectable_column
    column :id
    column 'Avatar' do |user|
      image_tag(user.avatar.url, height: 60) if user.avatar.present?
    end
    column :first_name
    column :last_name
    column :email

    actions
  end
  
end
