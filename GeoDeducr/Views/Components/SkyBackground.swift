//
//  SkyBackground.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

/// Sky gradient with a sun and a green lawn (Home, Splash, Game summary).
struct SkyBackground: View {
    var body: some View {
        LinearGradient(colors: [.skyTop, .skyBottom], startPoint: .top, endPoint: .bottom)
            .overlay(alignment: .bottom) {
                // a big ellipse pushed half below the screen = a rounded hill
                Ellipse()
                    .fill(Color.ground)
                    .frame(width: 900, height: 480)
                    .offset(y: 250)
            }
            .overlay(alignment: .top) {
                // the sun, to the right of the centre
                Circle()
                    .fill(Color.modeDailyFill)
                    .frame(width: 100, height: 100)
                    .offset(x: 110, y: 90)
            }
            .ignoresSafeArea()          // fill behind the status bar and home indicator too
            .accessibilityHidden(true)  // decoration only
    }
}

#Preview {
    SkyBackground()
}
