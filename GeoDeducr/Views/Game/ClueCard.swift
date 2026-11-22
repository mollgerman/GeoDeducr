import SwiftUI

/// One clue in the panel (Figma component "Clue Card").
struct ClueCard: View {
    let clue: Clue

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(clue.kind.title.uppercased())
                .font(.gdCaption)
                .foregroundStyle(Color.textSecondary)
            Text(clue.text)
                .font(.gdBody)
                .foregroundStyle(Color.textPrimary)
                .fixedSize(horizontal: false, vertical: true)   // wrap onto more lines, never cut off
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .chunkyBackground(fill: .white, lip: .surfaceLip, cornerRadius: 16, lineWidth: 2, lipHeight: 3)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ClueCard(clue: Clue(kind: .geography, text: "A river splits the city into a north bank and a south bank."))
        .padding()
}
