/// The five kinds of clue, in the order a round reveals them:
/// from the vaguest to the most revealing (Module 1 design, "Clue types").
enum ClueKind: Int, CaseIterable {
    case live, geography, language, food, famousFor

    /// The label on the clue card.
    var title: String {
        switch self {
        case .live:      return "Live fact"
        case .geography: return "Geography"
        case .language:  return "Language & culture"
        case .food:      return "Local food"
        case .famousFor: return "Famous for"
        }
    }
}
