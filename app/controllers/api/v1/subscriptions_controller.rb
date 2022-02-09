# frozen_string_literal: true

class Api::V1::SubscriptionsController < Api::BaseController
  skip_before_action :authorize_request, only: [ :generate_token ]

  def create
    response = ::Shopify::SubscriptionCreator.call(subscription_params)
    render json: response
  end

  def selling_plan_groups
    response = ::Shopify::SellingPlanGroups.call
    render json: response
  end

  def product_variant_join_selling_plan_groups
    response = ::Shopify::SellingPlanGroup::ProductVariantJoin.call(
      subscription_selling_plan_groups_params[:id],
      subscription_selling_plan_groups_params[:selling_plan_group_ids]
    )
    render json: response
  end

  def product_join_selling_plan_groups
    response = ::Shopify::SellingPlanGroup::ProductJoin.call(
      subscription_selling_plan_groups_params[:id],
      subscription_selling_plan_groups_params[:selling_plan_group_ids]
    )
    render json: response
  end

  def product_variant_leave_selling_plan_groups
    response = ::Shopify::SellingPlanGroup::ProductVariantJoin.call(
      subscription_selling_plan_groups_params[:id],
      subscription_selling_plan_groups_params[:selling_plan_group_ids]
    )
    render json: response
  end

  def product_leave_selling_plan_groups
    response = ::Shopify::SellingPlanGroup::ProductJoin.call(
      subscription_selling_plan_groups_params[:id],
      subscription_selling_plan_groups_params[:selling_plan_group_ids]
    )
    render json: response
  end

  def generate_token
    if params[:code] && params[:shop]
      store_access = ShopifyStoreAccess.find_by(store_name: params[:shop])
      store_access.destroy! if store_access

      store_access =  ShopifyStoreAccess.new(store_name: params[:shop])
      store_access.code = params[:code]

      respond = ::Shopify::AdminAccessTokenCreator.call(params[:code])
      if respond["access_token"]
        store_access.admin_access_token = respond["access_token"]
        respond = ::Shopify::StorefrontAccessTokenCreator.call(respond["access_token"])
        store_access.storefront_access_token = respond["access_token"] if respond["access_token"]
      end

      store_access.save
    end
    return render json: :ok
  end



  private

  def subscription_params
    params.require(:subscription).permit(
       :quantity, :product_variant_id, :selling_plan_id
    )
  end

  def subscription_selling_plan_groups_params
    params.require(:subscription_selling_plan_groups).permit(
       :id, selling_plan_group_ids: []
    )
  end
end
