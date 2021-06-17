class Search < ApplicationRecord
  validates :name, uniqueness: {scope: [:heavier_than,
                                        :lighter_than,
                                        :taller_than,
                                        :shorter_than,
                                        :hair_color,
                                        :skin_color,
                                        :eye_color,
                                        :birth_year,
                                        :gender]}
end
