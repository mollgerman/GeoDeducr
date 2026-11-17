//
//  GameMode+Style.swift
//  GeoDeducr
//
//  Created by stud on 17/11/2026.
//

import SwiftUI

/// How each mode looks. Colours are UI, so they live with the views.
extension GameMode {
    var fill: Color {
        switch self {
        case .daily:    return .modeDailyFill
        case .classic:  return .modeClassicFill
        case .speedRun: return .modeSpeedFill
        case .fewHints: return .modeHintsFill
        case .blitz:    return .modeBlitzFill
        }
    }

    var lip: Color {
        switch self {
        case .daily:    return .modeDailyLip
        case .classic:  return .modeClassicLip
        case .speedRun: return .modeSpeedLip
        case .fewHints: return .modeHintsLip
        case .blitz:    return .modeBlitzLip
        }
    }

    /// Dark text on gold (contrast), white on the other colours.
    var textColor: Color {
        self == .daily ? .modeDailyText : .white
    }
}
