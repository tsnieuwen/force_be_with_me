require 'rails_helper'

RSpec.describe Character, type: :model do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :height }
    it { should validate_presence_of :mass }
    it { should validate_presence_of :hair_color }
    it { should validate_presence_of :skin_color }
    it { should validate_presence_of :eye_color }
    it { should validate_presence_of :birth_year }
    it { should validate_presence_of :gender }
    it { should validate_uniqueness_of :name }

    it "happy path creates a character record with valid params" do
      character = Character.new(name: "Luke", height: 23, mass: 12, hair_color: "brown", skin_color: "blue", eye_color: "green", birth_year: "1234", gender: "male")
      expect(character.save).to eq(true)
    end

    it "sad path missing required param" do
      character = Character.new(name: "Luke", height: 23, mass: 12, skin_color: "blue", eye_color: "green", birth_year: "1234", gender: "male")
      expect(character.save).to eq(false)
    end

    it "sad path character name not unique" do
      character1 = Character.new(name: "Luke", height: 23, mass: 12, hair_color: "brown", skin_color: "blue", eye_color: "green", birth_year: "1234", gender: "male")
      character1.save
      character2 = Character.new(name: "Luke", height: 34, mass: 11, hair_color: "blonde", skin_color: "red", eye_color: "brown", birth_year: "432", gender: "female")
      expect(character2.save).to eq(false)
    end
  end

  describe 'class methods' do
    before(:each) do
      VCR.use_cassette('characters_filter') do
        Character.destroy_all
        CharactersFacade.import_characters
        @characters = Character.all
      end
    end

    it '.taller_search happy path' do
      pre_char_count = Character.count
      minimum_height = Character.minimum(:height)
      search_criteria = minimum_height + 15
      filtered_characters = @characters.taller_search(search_criteria)
      expect(filtered_characters.count).to be < pre_char_count
      expect(filtered_characters.minimum(:height)).to be >= search_criteria
    end

    it '.shorter_search happy path' do
      pre_char_count = Character.count
      maximum_height = Character.maximum(:height)
      search_criteria = maximum_height - 15
      filtered_characters = @characters.shorter_search(search_criteria)
      expect(filtered_characters.count).to be < pre_char_count
      expect(filtered_characters.maximum(:height)).to be <= maximum_height
    end

    it '.heavier_search happy path' do
      pre_char_count = Character.count
      minimum_mass = Character.minimum(:mass)
      search_criteria = minimum_mass + 15
      filtered_characters = @characters.heavier_search(search_criteria)
      expect(filtered_characters.count).to be < pre_char_count
      expect(filtered_characters.minimum(:mass)).to be >= search_criteria
    end

    it '.lighter_search happy path' do
      pre_char_count = Character.count
      maximum_mass = Character.maximum(:mass)
      search_criteria = maximum_mass - 15
      filtered_characters = @characters.lighter_search(search_criteria)
      expect(filtered_characters.count).to be < pre_char_count
      expect(filtered_characters.maximum(:mass)).to be <= maximum_mass
    end

    it '.discover_characters happy path name' do
      search_params = {name: "Darth Vader"}
      filtered_characters = @characters.discover_characters(search_params)
      expect(filtered_characters.count).to eq(1)
      expect(filtered_characters.first.name).to eq("Darth Vader")
    end

    it '.discover_characters happy path hair color' do
      search_params = {hair_color: "white"}
      filtered_characters = @characters.discover_characters(search_params).order(:hair_color)
      expect(filtered_characters.first.hair_color).to eq("white")
      expect(filtered_characters.last.hair_color).to eq("white")
    end

    it '.discover_characters happy path skin color' do
      search_params = {skin_color: "pale"}
      filtered_characters = @characters.discover_characters(search_params).order(:skin_color)
      expect(filtered_characters.first.skin_color).to eq("pale")
      expect(filtered_characters.last.skin_color).to eq("pale")
    end

    it '.discover_characters happy path eye color' do
      search_params = {eye_color: "yellow"}
      filtered_characters = @characters.discover_characters(search_params).order(:eye_color)
      expect(filtered_characters.first.eye_color).to eq("yellow")
      expect(filtered_characters.last.eye_color).to eq("yellow")
    end

    it '.discover_characters happy path birth year' do
      search_params = {birth_year: "92BBY"}
      filtered_characters = @characters.discover_characters(search_params).order(:birth_year)
      expect(filtered_characters.first.birth_year).to eq("92BBY")
      expect(filtered_characters.last.birth_year).to eq("92BBY")
    end

    it '.discover_characters happy path gender' do
      search_params = {gender: "male"}
      filtered_characters = @characters.discover_characters(search_params).order(:gender)
      expect(filtered_characters.first.gender).to eq("male")
      expect(filtered_characters.last.gender).to eq("male")
    end

  end
end
