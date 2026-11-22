/// One clue shown to the player during a round.
struct Clue: Identifiable, Hashable {
    let kind: ClueKind
    let text: String

    /// A round never shows two clues of the same kind, so the kind is a unique id.
    var id: ClueKind { kind }
}
