//
//  ScorePanel.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

/// The cream "TOTAL SCORE" panel under the board.
struct ScorePanel: View {
    let score: Int

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "trophy.fill")
                .font(.title)
                .foregroundStyle(Color.modeDailyFill)

            VStack(alignment: .leading, spacing: 0) {
                Text("TOTAL SCORE")
                    .font(.gdCaption)
                    .foregroundStyle(Color.textSecondary)
                Text("\(score.formatted()) pts")    // 999 999 or 999,999 depending on the region
                    .font(.gdTitle1)
                    .foregroundStyle(Color.textPrimary)
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 16)
        .padding(.trailing, 20)
        .chunkyBackground(fill: .surfaceCard, lip: .surfaceLip, cornerRadius: 22)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ScorePanel(score: 999_999)
        .padding()
}
