import SwiftUI

/// Placeholder for the Passport tab (Class 4). HIG: never hide a tab, explain its empty content.
struct PassportView: View {
    var body: some View {
        ContentUnavailableView(
            "No stamps yet",
            systemImage: "book.closed",
            description: Text("Every city you find gets a stamp here.")
        )
    }
}

#Preview {
    PassportView()
}
