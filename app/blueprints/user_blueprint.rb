# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :first_name, :last_name, :email, :phone, :avatar_url, :created_at

  fields :haircuts_count
  
end
