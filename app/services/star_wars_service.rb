class StarWarsService

  def self.import_data
    data = []
    page = "https://swapi.dev/api/people/?page=1"
    until page == nil
      response = Faraday.get(page)
      parsed = JSON.parse(response.body, symbolize_names: true)
      data << parsed[:results]
      parsed[:next] != nil ? page = parsed[:next].insert(4, "s") : page = nil
    end
    data.flatten
  end
end
