require 'rails_helper'

describe "Post searches" do
  before(:each) do
    VCR.use_cassette('import_characters_request_spec') do
      Character.destroy_all
      Search.destroy_all
      CharactersFacade.import_characters
      @characters = Character.all
    end
  end

  let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end

  it "should return character records" do
    before_size = Search.all.size
    valid_params = {name: 'Darth Vader'}
    post api_v1_characters_searches_path params: valid_params
    expect(response).to be_successful
    after_size = Search.all.size
    body = JSON.parse(response.body, symbolize_names: true)
    expect(before_size + 1).to eq(after_size)
    expect(Search.last.name).to eq("Darth Vader")
    expect(body[:data]).to be_an(Array)
    expect(body[:data].first.keys).to eq([:id, :type, :attributes])
    expect(body[:data].first[:id]).to be_a(String)
    expect(body[:data].first[:type]).to be_a(String)
    expect(body[:data].first[:attributes]).to be_a(Hash)
    expect(body[:data].first[:attributes].keys).to eq([:name, :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender])
  end

  it "should return 400 status and message if user inputs invalid search params" do
    before_size = Search.all.size
    valid_params = {name: 'Darth Vader', taller_than: "tall"}
    post api_v1_characters_searches_path params: valid_params
    expect(response).to_not be_successful
    after_size = Search.all.size
    expect(before_size).to eq(after_size)
    expect(response.body).to eq("No records matched the given search")
    expect(response.status).to eq(400)
  end

  it "should return 200 status and message if no records match the search" do
    before_size = Search.all.size
    valid_params = {name: 'Will Ferrell'}
    post api_v1_characters_searches_path params: valid_params
    expect(response).to_not be_successful
    after_size = Search.all.size
    expect(before_size + 1).to eq(after_size)
    expect(response.body).to eq("No records matched the given search")
  end

end
