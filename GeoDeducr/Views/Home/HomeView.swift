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

    var body: some View {
        ScrollView {    // scrolls on small iPhones (SE, mini), no bounce when everything fits
            VStack(spacing: 20) {
                LogoView()
                tagline
                ModeBoard()
                ScorePanel(score: totalScore)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background { SkyBackground() }
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
