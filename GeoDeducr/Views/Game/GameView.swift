import SwiftUI

/// Placeholder for the game screen. The map, clues and pin come in Class 2.
struct GameView: View {
    let mode: GameMode

    /// Closes this full-screen cover and goes back to Home.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text(mode.title)
                .font(.gdLargeTitle)
                .foregroundStyle(Color.textPrimary)
            Text(mode.subtitle)
                .font(.gdBody)
                .foregroundStyle(Color.textSecondary)

            Button("Quit to Home") {
                dismiss()
            }
            .font(.gdHeadline)
            .buttonStyle(.borderedProminent)
            .tint(Color.feedbackDanger)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { SkyBackground() }
    }
}

#Preview {
    GameView(mode: .classic)
}
