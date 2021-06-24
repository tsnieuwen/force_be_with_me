class Api::V1::CharactersController < ApplicationController

  def index
    @characters = Character.discover_characters(character_params)
    if @characters.empty?
      render json: "No records matched the given search", status: 200
    else
      render json: CharactersSerializer.new(@characters)
    end
  end

  private

  def character_params
    params.permit(:name,
                  :taller_than,
                  :shorter_than,
                  :heavier_than,
                  :lighter_than,
                  :hair_color,
                  :skin_color,
                  :eye_color,
                  :birth_year,
                  :gender,
                  :sort_by,
                  :sort_order,
                  :per_page,
                  :page)
  end
end
