// GeoDeducrModel.swift
// The game's data and rules — plain Swift, no SwiftUI.
// Tonight: paste this + Checks.swift into swiftfiddle.com and make every check ✅.
// Tomorrow: drag THIS file (not Checks.swift) into the Xcode project.

// MARK: - 1. GameMode  (worked example — read it, don't change it)

/// The five ways to play, exactly as in the Figma "Mode Card" component.
enum GameMode: String, CaseIterable, Identifiable {
    case daily, classic, speedRun, fewHints, blitz

    // Identifiable: every mode needs a unique id so SwiftUI's ForEach can tell them apart.
    var id: String { rawValue }

    var title: String {
        switch self {
        case .daily:    return "Daily Challenge"
        case .classic:  return "Classic"
        case .speedRun: return "Speed run"
        case .fewHints: return "Few hints"
        case .blitz:    return "Blitz"
        }
    }

    /// How many clues the player may unlock in one round.
    var clueCount: Int {
        switch self {
        case .daily, .classic, .speedRun: return 5
        case .fewHints:                   return 3
        case .blitz:                      return 2
        }
    }

    /// Seconds per round. `nil` means "no timer" — that's what the ? in Int? allows.
    var secondsPerRound: Int? {
        switch self {
        case .daily:               return 60
        case .speedRun:            return 30
        case .blitz:               return 15
        case .classic, .fewHints:  return nil
        }
    }

    /// The small line under the title, built from the numbers above.
    var subtitle: String {
        if self == .daily {
            return "Same 5 cities for everyone · 60 s"
        }
        if let seconds = secondsPerRound {          // "if there IS a timer, call it seconds"
            return "\(clueCount) clues · \(seconds) s per round"
        } else {
            return "\(clueCount) clues · no timer"
        }
    }

    /// SF Symbol names (shown with Image(systemName:) in SwiftUI tomorrow).
    var icon: String {
        switch self {
        case .daily:    return "star.fill"
        case .classic:  return "globe.europe.africa.fill"
        case .speedRun: return "stopwatch.fill"
        case .fewHints: return "lightbulb.fill"
        case .blitz:    return "bolt.fill"
        }
    }
}

// MARK: - 2. City  (your turn: add two more cities)

/// One city to guess. Clues go from hardest (first) to easiest (last).
struct City {
    let name: String
    let country: String
    let clues: [String]
    // Later (Phase 6.1): let imageName: String  → a photo in Assets.
    // 15 cities with a photo each = the course's "15 images" requirement done.
}

extension City {
    static let wroclaw = City(
        name: "Wrocław",
        country: "Poland",
        clues: [
            "More than 600 small bronze dwarf statues hide around this city.",
            "It is built on 12 islands linked by over 100 bridges.",
            "The river Oder (Odra) flows through it.",
            "It is the largest city of Lower Silesia.",
            "Its main square is called the Rynek, and it is in Poland.",
        ]
    )

    static let lisbon = City(
        name: "Lisbon",
        country: "Portugal",
        clues: [
            "A huge earthquake destroyed most of this city in 1755.",
            "It is built on seven hills, climbed by old yellow trams.",
            "The famous custard tart pastel de nata comes from here.",
            "It sits where the Tagus river meets the Atlantic.",
            "It is the capital of Portugal.",
        ]
    )

    static let tokyo = City(
        name: "Tokyo",
        country: "Japan",
        clues: [
            "Its old name was Edo.",
            "It hosted the Summer Olympics in 1964 and again in 2021.",
            "The busy Shibuya Crossing is here.",
            "Its metro area has more people than any other in the world.",
            "It is the capital of Japan.",
        ]
    )

    // TODO 1: add two more cities (any you like) with 5 clues each, hardest first.
    //         Then add them to this list so there are 5 — enough for a Daily Challenge.
    static let samples: [City] = [wroclaw, lisbon, tokyo]
}

// MARK: - 3. Round  (your turn: fill in the four TODOs)

/// One round = one city to guess in one mode.
/// Rules (from the Figma Clue Card): you start with 1 clue and a max of 5,000 points.
/// Each extra clue you unlock lowers the max by 1,000. A wrong guess scores 0.
struct Round {
    let city: City
    let mode: GameMode
    var cluesShown = 1

    static let maxScore = 5_000
    static let cluePenalty = 1_000

    /// The clues the player can see right now (the first `cluesShown` of them).
    var visibleClues: [String] {
        Array(city.clues.prefix(cluesShown))
    }

    /// TODO 2: true while the player may still unlock a clue:
    ///         cluesShown is smaller than mode.clueCount.
    var canUnlockClue: Bool {
        return false   // ← replace
    }

    /// TODO 3: if canUnlockClue is true, add 1 to cluesShown. Otherwise do nothing.
    /// `mutating` = this method changes the struct's own properties.
    mutating func unlockNextClue() {
        // ← write here
    }

    /// TODO 4: maxScore minus cluePenalty for every clue AFTER the first one.
    ///         1 clue → 5000, 2 clues → 4000, 3 clues → 3000 …
    var currentMaxScore: Int {
        return 0   // ← replace
    }

    /// TODO 5: if the guess is the city name → currentMaxScore, otherwise 0.
    ///         Upper/lower case must not matter: "wrocław" counts as "Wrocław".
    ///         Hint: String has .lowercased()
    func score(forGuess guess: String) -> Int {
        return 0   // ← replace
    }
}
