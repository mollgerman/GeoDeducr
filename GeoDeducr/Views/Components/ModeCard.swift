//
//  ModeCard.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

struct ModeCard: View {
    let title: String
    let subtitle: String
    let icon: String  // SF Symbol name
    let fill: Color
    let lip: Color
    var textColor: Color = .white
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.gdTitle3)
                Text(subtitle)
                    .font(.gdSubheadline)
            }

            Spacer()    // pushes the content left, stretches the card to full width
        }
        .foregroundStyle(textColor)
        .padding(12)
        .accessibilityElement(children: .combine)  // VoiceOver reads title + subtitle together
        .chunkyBackground(fill: fill, lip: lip)
    }
}

#Preview {
    VStack(spacing: 18) {
        ModeCard(title: "Daily Challenge", subtitle: "Same 5 cities for everyone · 60 s",
                 icon: "star.fill", fill: .modeDailyFill, lip: .modeDailyLip,
                 textColor: .modeDailyText)
        ModeCard(title: "Classic", subtitle: "5 clues · no timer",
                 icon: "globe.europe.africa.fill", fill: .modeClassicFill, lip: .modeClassicLip)
        ModeCard(title: "Speed run", subtitle: "5 clues · 30 s per round",
                 icon: "stopwatch.fill", fill: .modeSpeedFill, lip: .modeSpeedLip)
        ModeCard(title: "Few hints", subtitle: "3 clues · no timer",
                 icon: "lightbulb.fill", fill: .modeHintsFill, lip: .modeHintsLip)
        ModeCard(title: "Blitz", subtitle: "2 clues · 15 s per round",
                 icon: "bolt.fill", fill: .modeBlitzFill, lip: .modeBlitzLip)
    }
    .padding()
}
