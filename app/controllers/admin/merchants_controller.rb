class Admin::MerchantsController < ApplicationController
  
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:status].present?
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    end
  end
end