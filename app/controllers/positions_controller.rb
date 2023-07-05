class PositionsController < ApplicationController
  before_action :find_position, only: [:show, :update, :destroy]

  def index
    positions = Position.all
    render json: positions
  end

  def show
    render json: @position
  end

  def create
    position = Position.new(position_params)
    if position.save
      render json: position, status: :created
    else
      render json: { errors: position.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @position.update(position_params)
      render json: @position
    else
      render json: { errors: @position.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @position.destroy
  end

  private

  def find_position
    @position = Position.find(params[:id])
  end

  def position_params
    params.require(:position).permit(:name, :salary, :vacation_days)
  end
end
