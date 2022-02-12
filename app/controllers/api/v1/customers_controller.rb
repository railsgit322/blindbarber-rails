# frozen_string_literal: true

class Api::V1::CustomersController < Api::BaseController

  def index
    response = ::Shopify::Customers:.call
    render json: response
  end

  def create
    response = ::Shopify::Customer::CreateCustomer.call(customer_params)
    render json: response
  end

  def show
    response = ::Shopify::Customer::CreateCustomer.call(params[:id])
    render json: response
  end

  def update
    response = ::Shopify::Customer::CreateCustomer.call(customer_params)
    render json: response
  end

  def destroy
    response = ::Shopify::Customer::CreateCustomer.call(params[:id])
    render json: response
  end

  private

  def customer_params
    params.require(:customer).permit(
       :id, :firstName, :lastName, :email
    )
  end
end
