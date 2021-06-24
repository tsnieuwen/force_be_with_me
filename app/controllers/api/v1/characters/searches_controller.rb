class Api::V1::Characters::SearchesController < ApplicationController

  def create
    search = Search.new(search_params)
    characters = Character.discover_characters(params)
    if !search.save || characters.empty?
      render json: "No records matched the given search", status: 400
    else
      render json: CharactersSerializer.new(characters), status: 201
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
