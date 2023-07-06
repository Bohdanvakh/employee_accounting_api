class Api::V1::PositionHistoriesController < ApplicationController
  before_action :find_employee
  before_action :find_position_history, only: [:update]

  def create
    @position_history = PositionHistory.new(position_history_params)

    if @position_history.save
      render :create, status: :created
    else
      render_error(position_history)
    end
  end

  def edit
    @position_history = PositionHistory.find(params[:id])
  end

  def update
    if @position_history.update(position_history_params)
      render :update, status: :ok
    else
      render_error(@position_history)
    end
  end

  private

  def find_employee
    @employee = Employee.find(params[:employee_id])
  end

  def find_position_history
    @position_history = @employee.position_histories.find(params[:id])
  end

  def position_history_params
    params.require(:position_history).permit(:position_id, :employee_id, :started_on, :finished_on)
  end
end