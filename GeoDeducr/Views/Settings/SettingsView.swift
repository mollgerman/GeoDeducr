import SwiftUI

/// Placeholder for the Settings tab (Class 4).
struct SettingsView: View {
    var body: some View {
        ContentUnavailableView(
            "Settings",
            systemImage: "gearshape",
            description: Text("Sound, units and the tutorial will be here.")
        )
    }
}

#Preview {
    SettingsView()
}
