class CharactersFacade

  def self.import_characters
    data = StarWarsService.import_data
    data.each do |character|
      Character.create(
        name: character[:name],
        height: character[:height].to_i,
        mass: character[:mass].to_i,
        hair_color: character[:hair_color],
        skin_color: character[:skin_color],
        eye_color: character[:eye_color],
        birth_year: character[:birth_year],
        gender: character[:gender]
      )
    end
  end
end
