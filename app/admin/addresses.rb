ActiveAdmin.register Address do

  menu priority: 2
  permit_params :address1, :address2, :city, :province, :country, :zip, :company, :phone, :is_default, :user_id


  index do
    selectable_column
    column :id
    column :cust_name
    column :is_default
    column :address1
    column :address2
    column :city
    column :province
    column :country
    column :zip
    column :company
    column :phone

    actions
  end


  form do |f|
     f.inputs do
       f.input :user_id, :label => 'User',:as => :select, :class => 'form-control',:collection => User.all.map{|user| ["#{user.first_name} #{user.last_name}", user.id]}
       f.input :address1
       f.input :address2
       f.input :city
       f.input :province
       f.input :country
       f.input :zip
       f.input :company
       f.input :phone
       f.input :is_default
     end
     f.actions
   end

end
