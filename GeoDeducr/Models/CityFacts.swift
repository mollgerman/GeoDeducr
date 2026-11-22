/// The facts a city's clues are picked from: one list per kind of clue.
/// More facts per list = more variety, because each round picks one at random.
struct CityFacts: Codable, Hashable {
    let geography: [String]
    let language: [String]
    let food: [String]
    let famousFor: [String]
}
