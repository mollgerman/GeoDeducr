import SwiftUI
import Playgrounds

struct LogoView: View {
    let totalScore = 999_999
    var body: some View {
        HStack(spacing: 0) {
            Text("Geo").foregroundStyle(Color.brandAccent)
            Text("Deducr").foregroundStyle(Color.brand)
        }
        .font(.gdLogo)
        .shadow(color: .outline, radius: 0, x: 3, y: 0)
        .shadow(color: .outline, radius: 0, x: -3, y: 0)
        .shadow(color: .outline, radius: 0, x: 0, y: 3)
        .shadow(color: .outline, radius: 0, x: 0, y: -3)
        // the "lip" under the logo, from your Figma effect style (y: 5)
        .shadow(color: .outline, radius: 0, x: 0, y: 5)
    }
}


#Preview {
    LogoView()
        .padding()
        .background(Color.cyan.opacity(0.3))
}

#Playground {
    _ = 1 + 2
}
