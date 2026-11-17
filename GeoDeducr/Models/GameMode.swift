//
//  GameMode.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

/// The five ways to play (Module 1 design, "Game modes" table).
enum GameMode: String, CaseIterable, Identifiable {
    case daily, classic, speedRun, fewHints, blitz   // this order = order on the Home screen

    // Identifiable: ForEach needs a unique id for each item
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

    /// How many clues a round can show.
    var clueCount: Int {
        switch self {
        case .daily, .classic, .speedRun: return 5
        case .fewHints:                   return 3
        case .blitz:                      return 2
        }
    }

    /// Seconds per round
    var secondsPerRound: Int? {
        switch self {
        case .daily:              return 60
        case .speedRun:           return 30
        case .blitz:              return 15
        case .classic, .fewHints: return nil
        }
    }

    /// The small line under the title, built from the numbers above.
    var subtitle: String {
        if self == .daily {
            return "Same 5 cities for everyone · 60 s"
        }
        if let seconds = secondsPerRound {
            return "\(clueCount) clues · \(seconds) s per round"
        }
        return "\(clueCount) clues · no timer"
    }

    /// SF Symbol name for the card icon.
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
