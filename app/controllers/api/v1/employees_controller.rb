class Api::V1::EmployeesController < ApplicationController
  before_action :find_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all
  end

  def show
    @employee = @employee.decorate

    @vacations = @employee.vacations
    @total_vacation_days = @employee.total_vacation_days
    @salary = @employee.calculate_salary

    @position_histories = @employee.position_histories
    @last_position = @employee.last_position
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render :create
    else
      render_error(employee)
    end
  end

  def update
    if @employee.update(employee_params)
      render :update
    else
      render_error(@employee)
    end
  end

  def destroy
    @employee.destroy
  end

  private

  def find_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :passport_data, :date_of_birth, :place_of_birth, :home_address, :department_id)
  end
end
