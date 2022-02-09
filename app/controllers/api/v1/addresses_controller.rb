# frozen_string_literal: true

class Api::V1::AddressesController < Api::BaseController
  def index
    addresses = @current_user.addresses
    @addresses = AddressBlueprint.render(addresses)

    render json: @addresses, status: :ok
  end

  def default
    address = @current_user.addresses.find(params[:id])
    address_params[:is_default] = true
    address.update! address_params
    @address = AddressBlueprint.render(address)

    render json: @address, status: :ok
  end

  def show
    address = @current_user.addresses.find(params[:id])
    @address = AddressBlueprint.render(address)

    render json: @address, status: :ok
  end

  def update
		address = @current_user.addresses.find(params[:id])
		address.update! address_params
		@address = AddressBlueprint.render(address)

		render json: @address, status: :ok
  end

	def destroy
		address = @current_user.addresses.find(params[:id])
		address.destroy
		render json: {}, status: :ok
	end

  private

  def address_params
    params.require(:address).permit(
       :address1, :address2, :city, :province, :country, :zip, :company, :phone, :is_default, :created_at
    )
  end
end
