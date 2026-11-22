// Checks.swift — ONLY for swiftfiddle.com, do NOT add this file to Xcode.
// Paste it BELOW GeoDeducrModel.swift in the same SwiftFiddle editor and press Run.
// At first some lines print ❌ — that's expected. Finish the TODOs until all are ✅.
// (In Module 3 these same checks become real unit tests with @Test and #expect.)

func check(_ passed: Bool, _ name: String) {
    print(passed ? "✅ \(name)" : "❌ \(name)")
}

print("— GameMode —")
check(GameMode.allCases.count == 5, "there are 5 modes")
check(GameMode.blitz.subtitle == "2 clues · 15 s per round", "Blitz subtitle")
check(GameMode.classic.subtitle == "5 clues · no timer", "Classic subtitle")
check(GameMode.classic.secondsPerRound == nil, "Classic has no timer")

print("— City —")
check(City.samples.count == 5, "TODO 1: there are 5 sample cities")
check(City.samples.allSatisfy { $0.clues.count == 5 }, "every city has 5 clues")

print("— Round —")
var round = Round(city: .wroclaw, mode: .classic)
check(round.visibleClues.count == 1, "a round starts with 1 clue")
check(round.canUnlockClue, "TODO 2: you can unlock a clue at the start")
check(round.currentMaxScore == 5000, "TODO 4: max score starts at 5000")

round.unlockNextClue()
check(round.visibleClues.count == 2, "TODO 3: unlocking shows a 2nd clue")
check(round.currentMaxScore == 4000, "TODO 4: each extra clue costs 1000")

check(round.score(forGuess: "Wrocław") == 4000, "TODO 5: right guess scores the current max")
check(round.score(forGuess: "wrocław") == 4000, "TODO 5: case doesn't matter")
check(round.score(forGuess: "Kraków") == 0, "wrong guess scores 0")

var blitz = Round(city: .tokyo, mode: .blitz)
blitz.unlockNextClue()
blitz.unlockNextClue()
blitz.unlockNextClue()
check(blitz.visibleClues.count == 2, "TODO 3: Blitz never shows more than 2 clues")
check(blitz.canUnlockClue == false, "TODO 2: Blitz can't unlock a 3rd clue")

print("— Done —")
