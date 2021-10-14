class AuthorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def show
    author = Author.find(params[:id])

    render json: author
  end  
  
  # Change AuthorsController#create to send back the error messages if the new author is invalid
  def create
    author = Author.create!(author_params)

    render json: author, status: :created
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end
  
end
