//
//  SkyBackground.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

/// Sky gradient with a green lawn at the bottom (Home, Splash, Game summary).
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
            .ignoresSafeArea()   // fill behind the status bar and home indicator too
            .overlay(alignment: .top) {
                // a big ellipse pushed half below the screen = a rounded hill
                Circle()
                    .fill(Color.modeDailyFill)
                    .frame(width: 100, height: 100)
                    .offset(x: 110, y: 90)
            }
            .ignoresSafeArea()
        
    }
}

#Preview {
    SkyBackground()
}
