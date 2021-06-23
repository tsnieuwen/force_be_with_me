class Api::V1::Characters::SearchesController < ApplicationController

  def create
    if Search.create(search_params)
      searched_characters = Character.discover_characters(search_params)
      render json: CharactersSerializer.new(searched_characters)
    else
      render json:
    end 

  end

  private

  def search_params
    params.permit(:name,
                  :taller_than,
                  :shorter_than,
                  :heavier_than,
                  :lighter_than,
                  :hair_color,
                  :skin_color,
                  :eye_color,
                  :birth_year,
                  :gender)
  end
end
