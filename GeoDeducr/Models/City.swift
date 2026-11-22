import CoreLocation

/// One city to find. The list of cities is loaded from Resources/cities.json.
struct City: Codable, Identifiable, Hashable {
    let id: String            // short unique key, e.g. "paris"
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timeZone: String      // e.g. "Europe/Paris", for the local-time clue
    let photo: String         // image name in Assets
    let helloAudio: String?   // sound file name; optional because not every city has one yet
    let funFact: String
    let facts: CityFacts

    /// The city's position, in the type MapKit and Core Location use.
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
