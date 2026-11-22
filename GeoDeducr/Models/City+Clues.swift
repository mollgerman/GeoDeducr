import Foundation

/// Builds the clues for one round. Kept in the model (not in a view) so it can be unit-tested.
extension City {
    /// The clues for a round of `mode`, in reveal order (live → famous for).
    func makeClues(for mode: GameMode, now: Date = .now) -> [Clue] {
        // One clue per kind, in ClueKind order; a kind with no facts is skipped.
        let allClues = ClueKind.allCases.compactMap { kind -> Clue? in
            guard let text = clueText(for: kind, now: now) else { return nil }
            return Clue(kind: kind, text: text)
        }

        switch mode {
        case .daily, .classic, .speedRun:
            return allClues
        case .fewHints:
            return Array(allClues.prefix(3))   // food and famous-for are never shown
        case .blitz:
            // 2 random clues, put back into reveal order
            return allClues.shuffled().prefix(2).sorted { $0.kind.rawValue < $1.kind.rawValue }
        }
    }

    /// One random fact for the kind, or the city's local time for the live clue.
    private func clueText(for kind: ClueKind, now: Date) -> String? {
        switch kind {
        case .live:      return localTimeText(at: now)
        case .geography: return facts.geography.randomElement()
        case .language:  return facts.language.randomElement()
        case .food:      return facts.food.randomElement()
        case .famousFor: return facts.famousFor.randomElement()
        }
    }

    /// e.g. "Local time is 15:40." The live weather joins this clue in step 3.7.
    private func localTimeText(at date: Date) -> String {
        var style = Date.FormatStyle(date: .omitted, time: .shortened)   // e.g. 15:40 or 3:40 PM
        style.timeZone = TimeZone(identifier: timeZone) ?? .current       // the city's clock, not ours
        return "Local time is \(date.formatted(style))."
    }
}
