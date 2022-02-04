# frozen_string_literal: true

class AddressBlueprint < Blueprinter::Base
  identifier :id
  fields :address1, :address2, :city, :province, :country, :zip, :company, :phone, :is_default, :created_at
end
