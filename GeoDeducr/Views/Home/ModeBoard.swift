//
//  ModeBoard.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

/// The wooden board with the five mode cards.
struct ModeBoard: View {
    /// The mode the player tapped. HomeView owns it (@State); the board only changes it (@Binding).
    @Binding var selectedMode: GameMode?

    var body: some View {
        VStack(spacing: 12) {
            Text("Choose a mode")
                .font(.gdTitle2)
                .foregroundStyle(Color.textOnBoard)
                .shadow(color: .outline, radius: 0, y: 2)
                .accessibilityAddTraits(.isHeader)

            ForEach(GameMode.allCases) { mode in
                // Something the player taps is a Button (HIG), with our card as its label
                Button {
                    selectedMode = mode
                } label: {
                    ModeCard(
                        title: mode.title,
                        subtitle: mode.subtitle,
                        icon: mode.icon,
                        fill: mode.fill,
                        lip: mode.lip,
                        textColor: mode.textColor
                    )
                }
                .buttonStyle(.plain)   // keep our own look instead of the default blue button style
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 24)
        .chunkyBackground(fill: .surfaceBoard, lip: .outline, cornerRadius: 28, lipHeight: 8)
        .overlay { nails }
    }

    /// Four nails, one in each corner of the board.
    private var nails: some View {
        VStack {
            HStack { nail; Spacer(); nail }
            Spacer()
            HStack { nail; Spacer(); nail }
        }
        .padding(10)
        .accessibilityHidden(true)   // decoration only
    }

    private var nail: some View {
        Circle()
            .fill(Color.surfaceLip)
            .stroke(Color.outline, lineWidth: 2)
            .frame(width: 10, height: 10)
    }
}

#Preview {
    ModeBoard(selectedMode: .constant(nil))   // a fixed value, only for the preview
        .padding()
}
