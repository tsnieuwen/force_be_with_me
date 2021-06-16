class CharactersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender
end
