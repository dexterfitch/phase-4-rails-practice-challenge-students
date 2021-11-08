class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :student_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :student_invalid

    def index
        render json: Student.all
    end

    def show
        render json: Student.find(params[:id])
    end

    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: :created
    end

    def update
        this_student = Student.find(params[:id])
        this_student.update!(student_params)
        render json: this_student, status: :ok
    end

    def destroy
        this_student = Student.find(params[:id])
        this_student.destroy
        render status: :ok
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def student_not_found
        render json: { error: "Student not found" }, status: :not_found
    end

    def student_invalid(error_messages)
        render json: { errors: error_messages.records.errors.full_messages }, status: :unprocessable_entity
    end
end
