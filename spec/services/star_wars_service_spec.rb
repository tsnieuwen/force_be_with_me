require 'rails_helper'

RSpec.describe StarWarsService, type: :model do

  it "import data" do
    VCR.use_cassette('import_data') do

      expect(StarWarsService.import_data).to be_a(Array)
    end
  end
end
