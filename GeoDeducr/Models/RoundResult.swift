import CoreLocation

/// What happened in one round: where the player guessed, how far off it was and the points earned.
struct RoundResult: Identifiable {
    let id = UUID()
    let city: City
    let guess: CLLocationCoordinate2D
    let distanceKm: Double
    let maxPoints: Int
    let penalty: Int

    /// Never below 0, even for a guess on the other side of the world.
    var score: Int { max(maxPoints - penalty, 0) }

    init(city: City, guess: CLLocationCoordinate2D, cluesShown: Int) {
        self.city = city
        self.guess = guess

        let cityLocation = CLLocation(latitude: city.latitude, longitude: city.longitude)
        let guessLocation = CLLocation(latitude: guess.latitude, longitude: guess.longitude)
        distanceKm = guessLocation.distance(from: cityLocation) / 1_000   // metres → km

        maxPoints = Scoring.maxPoints(cluesShown: cluesShown)
        penalty = Scoring.distancePenalty(km: distanceKm)
    }
}
