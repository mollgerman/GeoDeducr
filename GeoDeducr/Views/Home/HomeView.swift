//
//  HomeView.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

struct HomeView: View {
    /// Sample value. The real saved score comes in step 4.1.
    private let totalScore = 999_999

    /// nil = no game running. Setting a mode opens the game full screen.
    @State private var selectedMode: GameMode?

    var body: some View {
        ScrollView {    // scrolls on small iPhones (SE, mini), no bounce when everything fits
            VStack(spacing: 20) {
                LogoView()
                tagline
                ModeBoard(selectedMode: $selectedMode)   // $ = pass a Binding, not a copy
                ScorePanel(score: totalScore)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background { SkyBackground() }
        .fullScreenCover(item: $selectedMode) { mode in
            GameView(viewModel: GameViewModel(mode: mode))    // closing it sets selectedMode back to nil
        }
    }

    private var tagline: some View {
        Text("Guess the city from the clues!")
            .font(.gdSubheadline)
            .foregroundStyle(Color.textPrimary)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .chunkyBackground(fill: .surfaceCard, lip: .outline, cornerRadius: 16,
                              lineWidth: 2.5, lipHeight: 3)
    }
}

#Preview {
    HomeView()
}
