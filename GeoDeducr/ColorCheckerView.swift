import SwiftUI

struct ColorCheckView: View {
    // name shown, the colour from Assets, the hex it should be (from Figma)
    let swatches: [(name: String, color: Color, hex: String)] = [
        ("brand", .brand, "#D9A066"),
        ("brandAccent", .brandAccent, "#7ED957"),
        ("outline", .outline, "#3B1F0A"),
        // ("cream", .cream, "?"),      // remove // if you still have these
        // ("wood", .wood, "?"),
        ("modeDailyFill", .modeDailyFill, "#FFC83D"),
        ("modeDailyLip", .modeDailyLip, "#B87A00"),
        ("modeDailyText", .modeDailyText, "#3B1F0A"),
        ("modeClassicFill", .modeClassicFill, "#2E7D32"),
        ("modeClassicLip", .modeClassicLip, "#1B4D1E"),
        ("modeSpeedFill", .modeSpeedFill, "#C2410C"),
        ("modeSpeedLip", .modeSpeedLip, "#7C2A07"),
        ("modeHintsFill", .modeHintsFill, "#1E5BC6"),
        ("modeHintsLip", .modeHintsLip, "#123A80"),
        ("modeBlitzFill", .modeBlitzFill, "#B91C1C"),
        ("modeBlitzLip", .modeBlitzLip, "#741010"),
        ("skyTop", .skyTop, "#5EB8F2"),
        ("skyBottom", .skyBottom, "#E6F8FF"),
        ("ground", .ground, "#4FA83D"),
        ("surfaceCard", .surfaceCard, "#FFF6E5"),
        ("surfaceBoard", .surfaceBoard, "#A0581F"),
        ("surfaceLip", .surfaceLip, "#D9A066"),
        ("textPrimary", .textPrimary, "#3B1F0A"),
        ("textSecondary", .textSecondary, "#6B3A12"),
        ("textOnBoard", .textOnBoard, "#FFF6E5"),
        ("feedbackSuccess", .feedbackSuccess, "#2E7D32"),
        ("feedbackWarning", .feedbackWarning, "#B87A00"),
        ("feedbackDanger", .feedbackDanger, "#B91C1C"),
    ]

    // as many 100-pt-wide columns as fit on the screen
    let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(swatches, id: \.name) { swatch in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(swatch.color)
                            .frame(height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.outline, lineWidth: 2)
                            )
                        Text(swatch.name).font(.gdCaption)
                        Text(swatch.hex).font(.gdCaption).foregroundStyle(.gray)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ColorCheckView()
}
