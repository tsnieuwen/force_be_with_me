class Api::V1::CharactersController < ApplicationController

  def index
    @characters = Character.limit(per_page.to_i).offset(page_offset)
    render json: CharactersSerializer.new(@characters)
  end

  private

  def per_page
    if params[:per_page].to_i != 0
      params[:per_page].to_i
    else
      20
    end
  end

  def page_offset
    if !params[:page] || params[:page].to_i == 0
      nil
    elsif params[:page].to_i <= 0
      0
    else
      (params[:page].to_i - 1) * per_page.to_i
    end
  end

end
