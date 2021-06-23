require 'rails_helper'

describe "Get characters" do
  before(:each) do
    VCR.use_cassette('import_characters_request_spec') do
      Character.destroy_all
      CharactersFacade.import_characters
      @characters = Character.all
    end

  end

  let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end

  it "should return character records" do
    get api_v1_characters_path
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to be_an(Array)
    expect(body[:data].first).to be_a(Hash)
    expect(body[:data].last).to be_a(Hash)
    expect(body[:data].first.keys).to eq([:id, :type, :attributes])
    expect(body[:data].last.keys).to eq([:id, :type, :attributes])
    expect(body[:data].first[:id]).to be_an(String)
    expect(body[:data].last[:id]).to be_an(String)
    expect(body[:data].first[:type]).to eq("characters")
    expect(body[:data].last[:type]).to eq("characters")
    expect(body[:data].first[:attributes].keys).to eq([:name, :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender])
    expect(body[:data].last[:attributes].keys).to eq([:name, :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender])

    expect(body[:data].first[:attributes][:name]).to be_a(String)
    expect(body[:data].first[:attributes][:height]).to be_an(Integer)
    expect(body[:data].first[:attributes][:mass]).to be_an(Integer)
    expect(body[:data].first[:attributes][:hair_color]).to be_a(String)
    expect(body[:data].first[:attributes][:skin_color]).to be_a(String)
    expect(body[:data].first[:attributes][:eye_color]).to be_a(String)
    expect(body[:data].first[:attributes][:birth_year]).to be_a(String)
    expect(body[:data].first[:attributes][:gender ]).to be_a(String)

    expect(body[:data].last[:attributes][:name]).to be_a(String)
    expect(body[:data].last[:attributes][:height]).to be_an(Integer)
    expect(body[:data].last[:attributes][:mass]).to be_an(Integer)
    expect(body[:data].last[:attributes][:hair_color]).to be_a(String)
    expect(body[:data].last[:attributes][:skin_color]).to be_a(String)
    expect(body[:data].last[:attributes][:eye_color]).to be_a(String)
    expect(body[:data].last[:attributes][:birth_year]).to be_a(String)
    expect(body[:data].last[:attributes][:gender ]).to be_a(String)

  end

  it "should default to 20 records in return if not otherwise specified" do
    get api_v1_characters_path
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].count).to eq(20)
  end

  it "should return the specified number of records" do
    valid_params = {per_page: '35'}
    get api_v1_characters_path, params: valid_params
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].count).to eq(35)
  end

  it "should return 20 records if user enters a non-integer string" do
    valid_params = {per_page: 'blue'}
    get api_v1_characters_path, params: valid_params
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].count).to eq(20)
  end

  it "should default to page 1 in return if not otherwise specified" do
    get api_v1_characters_path
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].first[:id].to_i).to eq(@characters[0].id)
    expect(body[:data].last[:id].to_i).to eq(@characters[19].id)
  end

  it "should return page number based on user specfication" do
    valid_params = {page: '2'}
    get api_v1_characters_path, params: valid_params
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].first[:id].to_i).to eq(@characters[20].id)
    expect(body[:data].last[:id].to_i).to eq(@characters[39].id)
  end

  it "should default to page 1 if user input is invalid" do
    valid_params = {page: 'blue'}
    get api_v1_characters_path, params: valid_params
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].first[:id].to_i).to eq(@characters[0].id)
    expect(body[:data].last[:id].to_i).to eq(@characters[19].id)
  end

  it "should return records based on two page and per_page params" do
    valid_params = {page: '2', per_page: '10'}
    get api_v1_characters_path, params: valid_params
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].first[:id].to_i).to eq(@characters[10].id)
    expect(body[:data].last[:id].to_i).to eq(@characters[19].id)
  end


end
