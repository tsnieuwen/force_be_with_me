class Search < ApplicationRecord
  validates :name, uniqueness: {scope: [:height,
                                        :mass,
                                        :hair_color,
                                        :skin_color,
                                        :eye_color,
                                        :birth_year,
                                        :gender]}
end
