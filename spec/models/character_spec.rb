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
  end
end
