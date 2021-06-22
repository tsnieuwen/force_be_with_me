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
    characters = characters.taller_search(search[:taller_than]) if search[:taller_than].present?
    characters = characters.shorter_search(search[:shorter_than]) if search[:shorter_than].present?
    characters = characters.heavier_search(search[:heavier_than]) if search[:heavier_than].present?
    characters = characters.lighter_search(search[:lighter_than]) if search[:lighter_than].present?
    return characters
  end

  def self.taller_search(minimum_height)
    where("height >= ?", minimum_height)
  end

  def self.shorter_search(maximum_height)
    where("height <= ?", maximum_height)
  end

  def self.heavier_search(minimum_mass)
    where("mass >= ?", minimum_mass)
  end

  def self.lighter_search(maximum_mass)
    where("mass <= ?", maximum_mass)
  end

end
