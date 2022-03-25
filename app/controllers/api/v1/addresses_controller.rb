# frozen_string_literal: true

class Api::V1::AddressesController < Api::BaseController
  def index
    response = Shopify::Addresses.call
    render json: response
  end

  def create
    response = Shopify::Address::CreateAddress.call(address_params)
    render json: response
  end

  def show
    response = Shopify::Address::ShowAddress.call(params[:address]["id"])
    render json: response
  end

  def update
    response = Shopify::Address::UpdateAddress.call(address_params)
    render json: response
  end

  def destroy
    response = Shopify::Address::DeleteAddress.call(params[:address]["id"])
    render json: response
  end

  private

  def address_params
    params.require(:address).permit(
      :id, :customer_id, :address1, :first_name, :last_name, :city, :province, :country_code, :zip, :phone
    )
  end
end
