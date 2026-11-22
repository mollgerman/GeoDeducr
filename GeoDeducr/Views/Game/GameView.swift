import SwiftUI
import MapKit

/// The game screen: a satellite map to drop a pin on, and a panel with the clues or the round result.
/// MVVM: this view only shows GameViewModel's state and calls its methods.
struct GameView: View {
    /// Passed in by HomeView, as in the W5 "Good MVVM" slide. @State keeps this first instance
    /// for as long as the screen is open, so the game is not reset when HomeView redraws.
    @State var viewModel: GameViewModel

    /// Which part of the world the map shows. It's UI state, so it lives in the View.
    @State private var cameraPosition: MapCameraPosition = Self.worldView
    @State private var isConfirmingQuit = false
    @Environment(\.dismiss) private var dismiss

    /// The camera stays at least 1,500 km above the ground (country level),
    /// so nobody can zoom in to recognise a city.
    private static let cameraBounds = MapCameraBounds(minimumDistance: 1_500_000)

    private static let worldView = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 30, longitude: 10),
            span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 140)
        )
    )

    var body: some View {
        Group {
            if let message = viewModel.errorMessage {
                errorView(message)
            } else {
                map
                    .safeAreaInset(edge: .bottom) {
                        CluePanel(viewModel: viewModel, onFinish: { dismiss() })
                            .padding(.horizontal, 12)
                            .padding(.bottom, 8)
                    }
                    .overlay(alignment: .topLeading) { quitButton }
            }
        }
        .task {
            if viewModel.cities.isEmpty {   // start only once, not every time the view appears
                viewModel.startGame()
            }
        }
        .onChange(of: viewModel.lastResult?.id) {
            if viewModel.lastResult != nil {
                withAnimation { cameraPosition = .automatic }   // zoom to show the pin and the city
            }
        }
        .onChange(of: viewModel.roundIndex) {
            withAnimation { cameraPosition = Self.worldView }   // new round: back to the whole world
        }
        .alert("Quit this game?", isPresented: $isConfirmingQuit) {
            Button("Quit", role: .destructive) { dismiss() }
            Button("Keep playing", role: .cancel) { }
        } message: {
            Text("Your points from this game will be lost.")
        }
    }

    private var map: some View {
        MapReader { proxy in
            Map(position: $cameraPosition, bounds: Self.cameraBounds) {
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
            .mapStyle(.imagery)   // satellite without labels: city names never give the answer away
            .onTapGesture { location in
                // MapProxy turns the tapped point on screen into a coordinate on the map
                if let coordinate = proxy.convert(location, from: .local) {
                    viewModel.placePin(at: coordinate)
                }
            }
        }
    }

    private var quitButton: some View {
        Button {
            isConfirmingQuit = true
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
                .frame(width: 44, height: 44)   // HIG: tap targets at least 44 × 44 pt
                .chunkyBackground(fill: .surfaceCard, lip: .surfaceLip, cornerRadius: 22, lipHeight: 4)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Quit game")
        .padding(.leading, 16)
        .padding(.top, 8)
    }

    /// W5 "Loading, error and empty states": say what happened and offer an action.
    private func errorView(_ message: String) -> some View {
        ContentUnavailableView {
            Label("Couldn't start the game", systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button("Try again") { viewModel.startGame() }
            Button("Back to Home") { dismiss() }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel(mode: .classic))
}
