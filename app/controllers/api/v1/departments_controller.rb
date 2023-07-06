class Api::V1::DepartmentsController < ApplicationController
  before_action :find_department, only: [:show, :update, :destroy, :employees]
  # decorates_assigned :department

  def index
    @departments = Department.all
  end

  def show
    employees = @department.employees
    @current_manager = Department.current_manager

  end

  def create
    department = Department.new(department_params)
    if department.save
      render :create, status: :created
    else
      render_error(department)
    end
  end

  def update
    if @department.update(department_params)
      render :show
    else
      render_error(@department)
    end
  end

  def destroy
    @department.destroy
    head :no_content
  end

  def employees
  end

  private

  def find_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :abbreviation)
  end
end
