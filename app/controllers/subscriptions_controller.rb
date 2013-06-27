class SubscriptionsController < ApplicationController
  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all

    render json: @plans
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])

    render json: @plan
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(params[:plan])

    if @plan.save
      render json: @plan, status: :created, location: @plan
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])

    if @plan.update(params[:plan])
      head :no_content
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    head :no_content
  end
end
