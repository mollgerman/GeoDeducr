import SwiftUI

/// The two-colour "GeoDeducr" wordmark with a dark outline and a lip.
struct LogoView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Geo").foregroundStyle(Color.brandAccent)
            Text("Deducr").foregroundStyle(Color.brand)
        }
        .font(.gdLogo)
        // SwiftUI has no text outline, so four hard shadows (right, left, down, up) draw one
        .shadow(color: .outline, radius: 0, x: 3, y: 0)
        .shadow(color: .outline, radius: 0, x: -3, y: 0)
        .shadow(color: .outline, radius: 0, x: 0, y: 3)
        .shadow(color: .outline, radius: 0, x: 0, y: -3)
        // the "lip" under the logo, from the Figma effect style (y: 5)
        .shadow(color: .outline, radius: 0, x: 0, y: 5)
    }
}

#Preview {
    LogoView()
        .padding()
        .background(Color.cyan.opacity(0.3))
}
