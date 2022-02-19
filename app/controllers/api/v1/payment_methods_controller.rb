# frozen_string_literal: true

class Api::V1::PaymentMethodsController < Api::BaseController

  def index
    response = ::Shopify::PaymentMethods.call(payment_method_params[:customer_id])
    render json: response
  end

  def create
    session = ::Shopify::PaymentMethod::CreateSession.call(payment_method_params[:payment_method_detail])
    if session and session["id"]
      response = ::Shopify::PaymentMethod::CreatePaymentMethod.call(payment_method_params, session) and session["id"])
    end
    render json: response
  end

  def update
    session = ::Shopify::PaymentMethod::CreateSession.call(payment_method_params[:payment_method_detail])
    if session and session["id"]
      response = ::Shopify::PaymentMethod::UpdatePaymentMethod.call(payment_method_params, session) and session["id"])
    end
    render json: response
  end

  def destroy
    response = ::Shopify::Customer::CreateCustomer.call(payment_method_params)
    render json: response
  end


  private

  def payment_method_params
    params.require(:payment_method).permit(
      :payment_method_id,
       :customer_id, :billing_address => [
         :address1, :address2, :city, :company, :country, :countryCode, :firstName, :lastName, :phone, :province, :proviceCode, :zip
       ], :payment_method_detail => [:number, :first_name, :last_name, :month, :year, :verification_result]
    )
  end
end
