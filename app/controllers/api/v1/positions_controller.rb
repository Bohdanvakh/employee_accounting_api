class Api::V1::PositionsController < ApplicationController
  before_action :find_position, only: [:show, :update, :destroy]

  def index
    @positions = Position.all
  end

  def show
  end

  def create
    position = Position.new(position_params)
    if position.save
      render :create, status: :created
    else
      render_error(position)
    end
  end

  def update
    if @position.update(position_params)
      render :update
    else
      render_error(@position)
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
