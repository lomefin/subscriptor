class ItemChargesController < ApplicationController
  # GET /item_charges
  # GET /item_charges.json
  def index
    @item_charges = ItemCharge.all

    render json: @item_charges
  end

  # GET /item_charges/1
  # GET /item_charges/1.json
  def show
    @item_charge = ItemCharge.find(params[:id])

    render json: @item_charge
  end

  # POST /item_charges
  # POST /item_charges.json
  def create
    @item_charge = ItemCharge.new(params[:item_charge])

    if @item_charge.save
      render json: @item_charge, status: :created, location: @item_charge
    else
      render json: @item_charge.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_charges/1
  # PATCH/PUT /item_charges/1.json
  def update
    @item_charge = ItemCharge.find(params[:id])

    if @item_charge.update(params[:item_charge])
      head :no_content
    else
      render json: @item_charge.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_charges/1
  # DELETE /item_charges/1.json
  def destroy
    @item_charge = ItemCharge.find(params[:id])
    @item_charge.destroy

    head :no_content
  end
end
