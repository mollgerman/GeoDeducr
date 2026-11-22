import Foundation
import OSLog

/// Loads the list of cities from cities.json, which is bundled with the app.
/// One job only: read the file and decode the JSON (lecture W5, "Good MVVM: clear layers").
struct CityService {
    enum LoadError: Error {
        case fileNotFound
    }

    func loadCities() throws -> [City] {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            Logger.cities.error("cities.json is missing from the app bundle")
            throw LoadError.fileNotFound
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase   // "fun_fact" → funFact
        let cities = try decoder.decode([City].self, from: data)

        Logger.cities.info("Loaded \(cities.count) cities")
        return cities
    }
}
