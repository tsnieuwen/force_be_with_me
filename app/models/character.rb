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
    characters = characters.limit(per_page(search)).offset(page_offset(search))
    characters = characters.sort_output(search)
    return characters
  end

  def self.taller_search(minimum_height)
    if minimum_height.to_i == 0
      minimum_height = Character.minimum(:height)
    end
    where("height >= ?", minimum_height)
  end

  def self.shorter_search(maximum_height)
    if maximum_height.to_i == 0
      maximum_height = Character.maximum(:height)
    end
    where("height <= ?", maximum_height)
  end

  def self.heavier_search(minimum_mass)
    if minimum_mass.to_i == 0
      minimum_mass = Character.minimum(:mass)
    end
    where("mass >= ?", minimum_mass)
  end

  def self.lighter_search(maximum_mass)
    if maximum_mass.to_i == 0
      maximum_mass = Character.maximum(:mass)
    end
    where("mass <= ?", maximum_mass)
  end

  def self.per_page(search)
    if search[:per_page] && (search[:per_page].to_i != 0)
      search[:per_page].to_i
    else
      20
    end
  end

  def self.page_offset(search)
    if !search[:page] || search[:page].to_i <= 0
      nil
    else
      (search[:page].to_i - 1) * per_page(search).to_i
    end
  end

  def self.sort_output(search)
    order("#{valid_attribute(search)} #{asc_or_desc(search)}")
  end

  def self.valid_attribute(search)
    character_attributes = ["name", "height", "mass", "hair_color", "skin_color", "eye_color", "birth_year", "gender"]
    if search[:sort_by] && (character_attributes.include? search[:sort_by])
      search[:sort_by]
    else
      "name"
    end
  end

  def self.asc_or_desc(search)
    valid_sorters = ["ASC", "DESC"]
    if search[:sort_order] && (valid_sorters.include? search[:sort_order])
      search[:sort_order]
    else
      "ASC"
    end
  end

end
