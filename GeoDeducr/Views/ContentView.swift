import SwiftUI

/// The root view: the app's three main sections in a tab bar (Module 1 design).
struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Passport", systemImage: "book.closed.fill") {
                PassportView()
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }
        .tint(Color.accent)   // the selected tab (and later every system control) in the accent green
    }
}

#Preview {
    ContentView()
}
