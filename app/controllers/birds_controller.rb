class BirdsController < ApplicationController

  def index
    @birds = Bird.visible_birds
    render json: @birds.to_json, status: :ok
  end

  def create
    @bird = Bird.new(birds_params)
    @bird.added ||= Time.now.utc.strftime("%F")
    if @bird.save
      render json: @bird.to_json, status: :created
    else
      render nothing: true, status: :bad_request
    end
  end

  def show
    @bird = Bird.find(params[:id])
    render json: @bird, status: :ok
  end

  def destroy
    @bird = Bird.find(params[:id])
    @bird.destroy
    render nothing: true, status: :ok
  end

  private

  def birds_params
    params.permit(:name, :family, :visible, :added, :continents => [])
  end
end