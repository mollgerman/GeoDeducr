//
//  ChunkyBackground.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

/// The GeoDeducr "toy" look: a filled rounded shape, a dark outline and a solid lip underneath.
/// The lip shadow is attached to the shape only, so text and icons on top stay clean.
struct ChunkyBackground: ViewModifier {
    let fill: Color
    let lip: Color
    var cornerRadius: CGFloat = 20
    var lineWidth: CGFloat = 3
    var lipHeight: CGFloat = 6

    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(fill)
                    .shadow(color: lip, radius: 0, y: lipHeight)
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color.outline, lineWidth: lineWidth)
            }
    }
}

extension View {
    /// Usage: `.chunkyBackground(fill: .surfaceCard, lip: .surfaceLip)`
    func chunkyBackground(fill: Color, lip: Color, cornerRadius: CGFloat = 20,
                          lineWidth: CGFloat = 3, lipHeight: CGFloat = 6) -> some View {
        modifier(ChunkyBackground(fill: fill, lip: lip, cornerRadius: cornerRadius,
                                  lineWidth: lineWidth, lipHeight: lipHeight))
    }
}
