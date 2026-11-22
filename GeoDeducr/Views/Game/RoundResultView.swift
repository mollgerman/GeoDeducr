import SwiftUI

/// The result of one round, shown in the panel after "Confirm guess":
/// city photo, distance and the points breakdown (Module 1 design, screen 5).
struct RoundResultView: View {
    let result: RoundResult
    let isLastRound: Bool
    let totalScore: Int
    let onNext: () -> Void
    let onFinish: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                cityPhoto
                VStack(alignment: .leading, spacing: 2) {
                    Text(result.city.name)
                        .font(.gdTitle2)
                    Text(result.city.country)
                        .font(.gdSubheadline)
                        .foregroundStyle(Color.textSecondary)
                    Text("\(Int(result.distanceKm.rounded()).formatted()) km away")
                        .font(.gdCallout)
                }
            }

            row("Max points for the clues used", result.maxPoints.formatted())
            row("Distance penalty", "−\(result.penalty.formatted())")
            Divider()
            row("Round score", result.score.formatted(), isTotal: true)
            if isLastRound {
                row("Game total", totalScore.formatted(), isTotal: true)
            }

            Button {
                if isLastRound {
                    onFinish()   // the Game summary screen comes in step 3.1
                } else {
                    onNext()
                }
            } label: {
                Text(isLastRound ? "Back to Home" : "Next round")
                    .font(.gdHeadline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .chunkyBackground(fill: .accent, lip: .outline, cornerRadius: 18, lipHeight: 4)
            }
            .buttonStyle(.plain)
        }
        .foregroundStyle(Color.textPrimary)
    }

    /// The photo from Assets on top of a placeholder; the placeholder shows until the photo is added.
    private var cityPhoto: some View {
        ZStack {
            Color.surfaceLip
            Image(systemName: "photo")
                .foregroundStyle(Color.textSecondary)
            Image(result.city.photo)
                .resizable()
                .scaledToFill()
        }
        .frame(width: 88, height: 88)
        .clipShape(.rect(cornerRadius: 12))
        .accessibilityLabel("Photo of \(result.city.name)")
    }

    private func row(_ title: String, _ value: String, isTotal: Bool = false) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
        .font(isTotal ? .gdHeadline : .gdCallout)
    }
}
