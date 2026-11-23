import CoreLocation
import Observation
import OSLog

/// Runs one game: 5 rounds, the clues of each round, the pin and the scores.
/// MVVM (lectures W4/W5): GameView shows this state and calls these methods;
/// it never touches City, Scoring or CityService directly.
@MainActor
@Observable
final class GameViewModel {
    static let roundsPerGame = 5

    let mode: GameMode

    // State the View reads. private(set): only this class may change it.
    private(set) var cities: [City] = []          // the cities of this game, one per round
    private(set) var roundIndex = 0               // 0 = first round
    private(set) var clues: [Clue] = []           // all clues prepared for this round
    private(set) var cluesShown = 1               // how many of them the player can see
    private(set) var pin: CLLocationCoordinate2D? // nil until the player taps the map
    private(set) var lastResult: RoundResult?     // set after "Confirm guess"
    private(set) var results: [RoundResult] = []  // one per finished round
    private(set) var errorMessage: String?
    private(set) var countries: [Country] = []    // borders and names drawn on the map

    private let service: CityService
    private let countryService: CountryService

    init(mode: GameMode, service: CityService = CityService(),
         countryService: CountryService = CountryService()) {
        self.mode = mode
        self.service = service
        self.countryService = countryService
    }

    // MARK: - Values derived from the state (the View only reads these)

    var currentCity: City? {
        cities.indices.contains(roundIndex) ? cities[roundIndex] : nil
    }
    var roundNumber: Int { roundIndex + 1 }
    var visibleClues: [Clue] { Array(clues.prefix(cluesShown)) }
    var canUnlockClue: Bool { cluesShown < clues.count && lastResult == nil }
    var currentMaxPoints: Int { Scoring.maxPoints(cluesShown: cluesShown) }
    var canConfirmGuess: Bool { pin != nil && lastResult == nil }
    var isLastRound: Bool { roundIndex == cities.count - 1 }
    var totalScore: Int { results.reduce(0) { $0 + $1.score } }

    // MARK: - Actions (called by the View)

    /// Loads the cities and starts round 1 with 5 random ones.
    func startGame() {
        loadCountriesIfNeeded()
        do {
            let allCities = try service.loadCities()
            cities = Array(allCities.shuffled().prefix(Self.roundsPerGame))
            results = []
            roundIndex = 0
            errorMessage = nil
            startRound()
        } catch {
            errorMessage = "The cities could not be loaded."
            Logger.game.error("Starting a game failed: \(error.localizedDescription)")
        }
    }

    /// Shows one more clue; the round's maximum drops by 1,000 (see Scoring).
    func unlockNextClue() {
        guard canUnlockClue else { return }
        cluesShown += 1
    }

    /// The player tapped the map. The pin can move until the guess is confirmed.
    func placePin(at coordinate: CLLocationCoordinate2D) {
        guard lastResult == nil else { return }
        pin = coordinate
    }

    /// Scores the pin against the real city.
    func confirmGuess() {
        guard canConfirmGuess, let pin, let city = currentCity else { return }
        let result = RoundResult(city: city, guess: pin, cluesShown: cluesShown)
        lastResult = result
        results.append(result)
        Logger.game.info("Round \(self.roundNumber): \(result.score) points")
    }

    /// Moves on after the Round result. The summary after the last round comes in step 3.1.
    func nextRound() {
        guard !isLastRound else { return }
        roundIndex += 1
        startRound()
    }

    // MARK: - Private

    /// The borders only decorate the map: if they fail to load, the game still works without them.
    private func loadCountriesIfNeeded() {
        guard countries.isEmpty else { return }
        do {
            countries = try countryService.loadCountries()
        } catch {
            Logger.map.error("Loading country borders failed: \(error.localizedDescription)")
        }
    }

    /// Resets everything that belongs to one round.
    private func startRound() {
        clues = currentCity?.makeClues(for: mode) ?? []
        cluesShown = 1
        pin = nil
        lastResult = nil
    }
}
