require 'rails_helper'

RSpec.describe Search, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of(:name).scoped_to( :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender) }
  end
end
