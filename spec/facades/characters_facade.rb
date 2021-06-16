require 'rails_helper'

RSpec.describe CharactersFacade, type: :model do

  it "import characters" do
    VCR.use_cassette('import_characters') do
      CharactersFacade.import_characters
      require "pry"; binding.pry
      expect(Character.all.count).to eq(82)
    end
  end
end
