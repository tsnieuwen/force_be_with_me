require 'rails_helper'

RSpec.describe CharactersFacade, type: :model do

  it "import characters" do
    VCR.use_cassette('import_characters') do
      CharactersFacade.import_characters
      expect(Character.all.count).to eq(82)
    end
  end
end
