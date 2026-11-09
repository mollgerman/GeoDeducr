import SwiftUI
import Playgrounds

struct ContentView: View {
    let totalScore = 999_999
    var body: some View {
        HStack(spacing: 0) {
            Text("Geo").foregroundStyle(Color.brandAccent)
            Text("Deducr").foregroundStyle(Color.brand)
        }
        .font(.gdLogo)
        Text("Total: \(totalScore.formatted()) pts")
            .font(.gdHeadline)
            .padding()
            .foregroundStyle(Color.cream)
            .background(Color.wood)
        }
}


#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
