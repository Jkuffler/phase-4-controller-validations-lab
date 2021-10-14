class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  # Change PostsController#update to send back the error messages if the updated post is invalid
  def update
    post = Post.find(params[:id])

    post.update!(post_params)

    render json: post
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end

end
