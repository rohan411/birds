class BirdsController < ApplicationController

  def index
    @birds = Bird.visible_birds
    render json: @birds.to_json, status: :ok
  end

  def create
    param! :name,        String, required: true
    param! :family,      String, required: true
    param! :visible,     Boolean
    param! :added,       String
    param! :continents,  Array, required: true do |array,index|
      array.param! index, String, required: true
    end
    @bird = Bird.new(birds_params)
    @bird.save
    render json: @bird.to_json, status: :created
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