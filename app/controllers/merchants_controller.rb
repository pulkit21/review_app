class MerchantsController < ApplicationController

  before_action :set_merchant, only: [:show, :update, :destroy]

  def index
    @merchants = Merchant.all
    render json: @merchants, status: 200
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      render :show, format: :json, status: 201
    else
      render json: @merchant.errors, status: 422
    end
  end

  def show
    render :show, format: :json, status: 200
  end

  def update
    if @merchant.update(merchant_params)
      render :show, format: :json, status: 200
    else
      render json: @merchant.errors, status: 422
    end
  end

  def destroy
    @merchant.destroy
    render json: @merchant, status: 204
  end


  #######
  private
  #######

  def merchant_params
    params.require(:merchant).permit(:name, :description)
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
