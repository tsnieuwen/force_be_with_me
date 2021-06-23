class Api::V1::Characters::SearchesController < ApplicationController

  def create
    search = Search.new(search_params)
    if search.save
      searched_characters = Character.discover_characters(search_params)
      render json: CharactersSerializer.new(searched_characters)
    else
      render json: "Search could not be executed", status: 400
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
