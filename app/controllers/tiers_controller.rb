class TiersController < ApplicationController
  # GET /tiers
  # GET /tiers.json
  def index
    @tiers = Tier.all

    render json: @tiers
  end

  # GET /tiers/1
  # GET /tiers/1.json
  def show
    @tier = Tier.find(params[:id])

    render json: @tier
  end

  # POST /tiers
  # POST /tiers.json
  def create
    @tier = Tier.new(params[:tier])

    if @tier.save
      render json: @tier, status: :created, location: @tier
    else
      render json: @tier.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tiers/1
  # PATCH/PUT /tiers/1.json
  def update
    @tier = Tier.find(params[:id])

    if @tier.update(params[:tier])
      head :no_content
    else
      render json: @tier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tiers/1
  # DELETE /tiers/1.json
  def destroy
    @tier = Tier.find(params[:id])
    @tier.destroy

    head :no_content
  end
end
