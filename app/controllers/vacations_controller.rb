class VacationsController < ApplicationController
  before_action :find_employee

  def create
    vacation = Vacation.new(vacation_params)

    if vacation.save
      render json: vacation, status: :created
    else
      render json: { errors: vacation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_employee
    @employee = Employee.find(params[:employee_id])
  end

  def vacation_params
    params.require(:vacation).permit(:started_on, :finished_on, :employee_id)
  end
end
