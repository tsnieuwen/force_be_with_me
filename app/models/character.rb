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

  def self.discover_characters(search)
    characters = Character.all
    characters = characters.where('name ILIKE ?', "#{search[:name]}") if search[:name].present?
    characters = characters.where(hair_color: "#{search[:hair_color]}") if search[:hair_color].present?
    characters = characters.where(skin_color: "#{search[:skin_color]}") if search[:skin_color].present?
    characters = characters.where(eye_color: "#{search[:eye_color]}") if search[:eye_color].present?
    characters = characters.where(birth_year: "#{search[:birth_year]}") if search[:birth_year].present?
    characters = characters.where(gender: "#{search[:gender]}") if search[:gender].present?

  end
end
