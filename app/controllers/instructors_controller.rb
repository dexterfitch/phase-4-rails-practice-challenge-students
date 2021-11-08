class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :instructor_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :instructor_invalid

    def index
        render json: Instructor.all
    end

    def show
        render json: Instructor.find(params[:id])
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: :created
    end

    def update
        this_instructor = Instructor.find(params[:id])
        this_instructor.update!(instructor_params)
        render json: this_instructor, status: :ok
    end

    def destroy
        this_instructor = Instructor.find(params[:id])
        this_instructor.destroy
        render status: :ok
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def instructor_not_found
        render json: { error: "Instructor not found" }, status: :not_found
    end

    def instructor_invalid(error_messages)
        render json: { errors: error_messages.records.errors.full_messages }, status: :unprocessable_entity
    end
end
