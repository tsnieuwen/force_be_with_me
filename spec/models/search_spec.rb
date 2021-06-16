require 'rails_helper'

RSpec.describe Search, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of(:name).scoped_to( :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender) }
  end

  it "happy path creates a search record" do
    search = Search.new(name: "Luke", height: 23)
    expect(search.save).to eq(true)
  end

  it "happy path creates a search record with some identical params" do
    search1 = Search.new(name: "Luke", height: 23, mass: 345)
    search1.save
    search2 = Search.new(name: "Luke", height: 23, mass: 45)
    expect(search2.save).to eq(true)
  end

  it "sad path does not create a search record with all identical params" do
    search1 = Search.new(name: "Luke", height: 23, mass: 345)
    search1.save
    search2 = Search.new(name: "Luke", height: 23, mass: 345)
    expect(search2.save).to eq(false)
  end

end
