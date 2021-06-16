class Character < ApplicationRecord
  validates :name,
            :height,
            :mass,
            :hair_color,
            :skin_color,
            :eye_color,
            :birth_year,
            :gender,
            presence: true

  validates :name, uniqueness: true
end
