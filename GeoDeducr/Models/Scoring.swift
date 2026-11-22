/// The scoring rules from the Module 1 design, in one place so they are easy to change and to test.
/// A caseless enum is used as a namespace: it groups the rules and can't be created by mistake.
enum Scoring {
    static let maxPointsPerRound = 5_000
    static let pointsPerExtraClue = 1_000
    static let fullPointsRadiusKm = 25.0
    /// Points lost per km beyond 25 km. 0.4 gives 412 km → −155, close to the design's example (−150).
    static let penaltyPerKm = 0.4

    /// 1 clue → 5,000 · 2 clues → 4,000 · … · 5 clues → 1,000
    static func maxPoints(cluesShown: Int) -> Int {
        maxPointsPerRound - (cluesShown - 1) * pointsPerExtraClue
    }

    /// No penalty within 25 km of the city; after that it grows with the distance.
    static func distancePenalty(km: Double) -> Int {
        guard km > fullPointsRadiusKm else { return 0 }
        return Int(((km - fullPointsRadiusKm) * penaltyPerKm).rounded())
    }
}
