import OSLog

/// The app's loggers (lecture W4: use Logger instead of print()).
/// Apple recommends the app's bundle identifier as the subsystem and one category per area.
extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "GeoDeducr"

    static let cities = Logger(subsystem: subsystem, category: "Cities")
    static let game = Logger(subsystem: subsystem, category: "Game")
}
