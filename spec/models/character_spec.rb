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

    # it '.height_search' do
    #   taller = 200
    #   shorter = 230
    #   filter_characters = @characters.height_search(taller, shorter)
    #   require "pry"; binding.pry
    # end


  end
end
