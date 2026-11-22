import SwiftUI

/// The cream panel under the map: the clues while guessing, the round result after "Confirm guess".
struct CluePanel: View {
    /// GameViewModel is @Observable, so a plain property is enough: this view redraws when what it reads changes.
    let viewModel: GameViewModel
    /// Called by "Back to Home" after the last round.
    let onFinish: () -> Void

    /// Only this panel cares whether all clues are listed, so the state lives here.
    @State private var showsAllClues = false

    var body: some View {
        VStack(spacing: 12) {
            header
            if let result = viewModel.lastResult {
                RoundResultView(
                    result: result,
                    isLastRound: viewModel.isLastRound,
                    totalScore: viewModel.totalScore,
                    onNext: { viewModel.nextRound() },
                    onFinish: onFinish
                )
            } else {
                clues
                guessButton
            }
        }
        .padding(16)
        .chunkyBackground(fill: .surfaceCard, lip: .surfaceLip, cornerRadius: 24)
        .animation(.spring, value: viewModel.cluesShown)
        .animation(.spring, value: showsAllClues)
        .onChange(of: viewModel.roundIndex) {
            showsAllClues = false
        }
    }

    private var header: some View {
        HStack {
            Text("Round \(viewModel.roundNumber) of \(viewModel.cities.count)")
            Spacer()
            if viewModel.lastResult == nil {
                Label(viewModel.currentMaxPoints.formatted(), systemImage: "star.fill")
                    .accessibilityLabel("Up to \(viewModel.currentMaxPoints) points")
            }
        }
        .font(.gdHeadline)
        .foregroundStyle(Color.textPrimary)
    }

    /// The newest clue (or all of them), and the button to unlock the next one.
    @ViewBuilder
    private var clues: some View {
        let shownClues = showsAllClues ? viewModel.visibleClues : Array(viewModel.visibleClues.suffix(1))

        ForEach(shownClues) { clue in
            ClueCard(clue: clue)
        }

        if viewModel.visibleClues.count > 1 {
            Button(showsAllClues ? "Show the newest clue only" : "Show all \(viewModel.visibleClues.count) clues") {
                showsAllClues.toggle()
            }
            .font(.gdFootnote)
            .foregroundStyle(Color.textSecondary)
        }

        if viewModel.canUnlockClue {
            Button {
                viewModel.unlockNextClue()
            } label: {
                HStack {
                    Image(systemName: "lock.open.fill")
                    Text("Unlock next clue")
                    Spacer()
                    Text("−1,000")
                }
                .font(.gdHeadline)
                .foregroundStyle(Color.textOnBoard)
                .padding(12)
                .chunkyBackground(fill: .surfaceBoard, lip: .outline, cornerRadius: 16, lipHeight: 4)
            }
            .buttonStyle(.plain)
            .accessibilityHint("Lowers the maximum points of this round by 1,000")
        }
    }

    private var guessButton: some View {
        Button {
            viewModel.confirmGuess()
        } label: {
            Text(viewModel.pin == nil ? "Tap the map to drop a pin" : "Confirm guess")
                .font(.gdHeadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .chunkyBackground(fill: viewModel.canConfirmGuess ? .accent : .textSecondary,
                                  lip: .outline, cornerRadius: 18, lipHeight: 4)
        }
        .buttonStyle(.plain)
        .disabled(!viewModel.canConfirmGuess)
    }
}
