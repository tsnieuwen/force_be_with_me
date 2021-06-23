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
  validates :heavier_than, numericality: true, :allow_nil => true
  validates :lighter_than, numericality: true, :allow_nil => true
  validates :shorter_than, numericality: true, :allow_nil => true
  validates :taller_than, numericality: true, :allow_nil => true

end
