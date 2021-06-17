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
    characters = characters.height_search(search[:taller_than], search[:shorter_than]) if search[:taller_than].present? || search[:shorter_than].present?
    characters = characters.mass_search(search[:heavier_than], search[:lighter_than]) if search[:heavier_than].present? || search[:lighter_than].present?
  end

  def self.height_search(taller = nil, shorter = nil)
    taller = Character.minimum(:height) if taller.nil?
    shorter = Character.maximum(:height) if shorter.nil?
    where('height >= ? AND height =< ?', taller, shorter)
  end

  def self.mass_search(heavier = nil, lighter = nil)
    heavier = Character.minimum(:mass) if heavier.nil?
    lighter = Character.maximum(:mass) if shorter.nil?
    where('mass >= ? AND mass =< ?', heavier, lighter)
  end
end
