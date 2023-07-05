class DepartmentsController < ApplicationController
  before_action :find_department, only: [:show, :update, :destroy, :employees]

  def index
    departments = Department.all
    render json: departments
  end

  def show
    employees = @department.employees
    render json: @department, include: :employees
  end

  def create
    department = Department.new(department_params)
    if department.save
      render json: department, status: :created
    else
      render json: { errors: department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: { errors: @department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @department.destroy
    head :no_content
  end

  def employees
    employees = @department.employees
    render json: employees
  end

  private

  def find_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :abbreviation)
  end
end
