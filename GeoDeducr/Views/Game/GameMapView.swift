import SwiftUI
import MapKit

/// The map of a round: satellite imagery with country borders and names on top,
/// the player's pin, and after the guess the real city with a dashed line to the pin.
struct GameMapView: View {
    let viewModel: GameViewModel
    /// Owned by GameView, which moves the camera between rounds.
    @Binding var cameraPosition: MapCameraPosition

    /// Camera height above the ground, in metres. It decides how many country names fit.
    @State private var cameraDistance: Double = 20_000_000

    /// Country level: the camera stays at least 1,500 km above the ground,
    /// so nobody can zoom in to recognise a city.
    private static let cameraBounds = MapCameraBounds(minimumDistance: 5000)

    var body: some View {
        MapReader { proxy in
            Map(position: $cameraPosition, bounds: Self.cameraBounds) {
                 borders
                 //countryNames
                guessAndAnswer
            }
            .mapStyle(.imagery)          // satellite without labels: city names never give the answer away
            .onMapCameraChange { context in
                cameraDistance = context.camera.distance
            }
            .onTapGesture { location in
                // MapProxy turns the tapped point on screen into a coordinate on the map
                if let coordinate = proxy.convert(location, from: .local) {
                    viewModel.placePin(at: coordinate)
                }
            }
        }
    }

    /// One thin white outline per country part (mainland, islands…).
    @MapContentBuilder
    private var borders: some MapContent {
        ForEach(viewModel.countries) { country in
            ForEach(country.outlines.indices, id: \.self) { index in
                MapPolygon(coordinates: country.outlines[index])
                    .foregroundStyle(Color.clear)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
            }
        }
    }

    /// Country names: country names help, city names would give the answer away.
    @MapContentBuilder
    private var countryNames: some MapContent {
        ForEach(visibleCountries) { country in
            Annotation(country.name, coordinate: country.labelCoordinate, anchor: .center) {
                Text(country.name)
                    .font(.gdCaption)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.9), radius: 2)
                    .allowsHitTesting(false)   // a tap on a name still drops a pin there
            }
            ForEach(visibleCountries) { country in
                Annotation(country.name, coordinate: country.labelCoordinate, anchor: .center) {
                    Text(country.name)
                        .font(.gdCaption)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.9), radius: 2)
                        .allowsHitTesting(false)   // a tap on a name still drops a pin there
                }
                .annotationTitles(.hidden)   // hide MapKit's own title; our Text is the label
            }
        }
    }

    /// The pin, and after "Confirm guess" the real city and the line between them.
    @MapContentBuilder
    private var guessAndAnswer: some MapContent {
        if let pin = viewModel.pin {
            Marker("Your guess", systemImage: "mappin", coordinate: pin)
                .tint(Color.feedbackDanger)
        }
        if let result = viewModel.lastResult {
            Marker(result.city.name, systemImage: "star.fill", coordinate: result.city.coordinate)
                .tint(Color.feedbackSuccess)
            MapPolyline(coordinates: [result.guess, result.city.coordinate])
                .stroke(Color.outline, style: StrokeStyle(lineWidth: 3, dash: [8, 6]))
        }
    }

    /// Zoomed out, only the big countries are named; zooming in shows smaller ones too.
    /// Natural Earth's label rank (2 = most important) decides which come first.
    private var visibleCountries: [Country] {
        let maxRank: Int
        switch cameraDistance {
        case 10_000_000...:          maxRank = 2
        case 5_000_000..<10_000_000: maxRank = 3
        case 2_500_000..<5_000_000:  maxRank = 4
        default:                     maxRank = 7
        }
        return viewModel.countries.filter { $0.labelRank <= maxRank }
    }
}
