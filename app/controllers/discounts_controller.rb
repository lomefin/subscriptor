class DiscountsController < ApplicationController
  # GET /discounts
  # GET /discounts.json
  def index
    @discounts = Discount.all

    render json: @discounts
  end

  # GET /discounts/1
  # GET /discounts/1.json
  def show
    @discount = Discount.find(params[:id])

    render json: @discount
  end

  # POST /discounts
  # POST /discounts.json
  def create
    @discount = Discount.new(params[:discount])

    if @discount.save
      render json: @discount, status: :created, location: @discount
    else
      render json: @discount.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /discounts/1
  # PATCH/PUT /discounts/1.json
  def update
    @discount = Discount.find(params[:id])

    if @discount.update(params[:discount])
      head :no_content
    else
      render json: @discount.errors, status: :unprocessable_entity
    end
  end

  # DELETE /discounts/1
  # DELETE /discounts/1.json
  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy

    head :no_content
  end
end
