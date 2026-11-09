# GeoDeducr – Learning Log

Single source of truth between sessions. Read this first in every new session.

## How we work (agreed 2026-10-26)
1. Claude explains one concept briefly, **with an official source link**.
2. You write the code yourself (or copy-paste when Claude says it's boilerplate).
3. Claude reviews, you run it, we log the decision here.
4. Claude never generates whole features without you asking. Claude asks before every decision.
5. Short answers. No teaching without a source.

## Official guides we follow
- Swift language: [A Swift Tour](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour/)
- SwiftUI step by step: [Apple SwiftUI Tutorials (Landmarks)](https://developer.apple.com/tutorials/swiftui)
- Files & folders: [Managing files and folders in your Xcode project](https://developer.apple.com/documentation/xcode/managing-files-and-folders-in-your-xcode-project)
- Fonts: [Applying custom fonts to text](https://developer.apple.com/documentation/swiftui/applying-custom-fonts-to-text)
- Reusable styles: [ViewModifier](https://developer.apple.com/documentation/swiftui/viewmodifier), [ButtonStyle](https://developer.apple.com/documentation/swiftui/buttonstyle)
- Colors: [Asset management](https://developer.apple.com/documentation/xcode/asset-management) + Xcode 15 release notes (generated asset symbols, e.g. `Color(.myColor)`)
- Data/state: [Managing model data in your app](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)

## Decisions
| # | Date | Decision | Why |
|---|------|----------|-----|
| 1 | 2026-10-26 | First screen to build: **Home** | Covers layout, colors, fonts and a reusable component |
| 2 | 2026-10-26 | Log lives in `docs/LEARNING_LOG.md` | Next to the design docs |
| 3 | 2026-10-26 | Fonts (Nunito, Luckiest Guy): **you download them** | — |
| 4 | 2026-10-26 | Run on **Simulator** | — |
| 5 | 2026-10-26 | Structure **by layer**: `Views/`, `Model/`, `Resources/` | Same as Apple's Landmarks tutorial ("Building lists and navigation" step: group files into Views, Model, Resources). Alternative (by feature) was rejected: not in Apple docs, more than we need now |

## Project facts (verified)
- Xcode 16+ **buildable folders**: folders on disk = groups in Xcode; any `.swift` file you drop in `GeoDeducr/` is compiled automatically. Source: Xcode 16 release notes.
- Deployment target iOS 27. Main-actor isolation by default (`SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`).
- Asset symbol generation is ON: a color set named `Wood` becomes `Color.wood` in code.
- Your Mac points to Command Line Tools instead of Xcode. Fix once (needs your password):
  `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`

## Progress
- [x] Read the functional design (PDF)
- [x] Choose structure (by layer)
- [x] Lesson 1: anatomy of the starter project (`MyApp.swift`, `ContentView.swift`) + Swift basics. You wrote `let totalScore` + string interpolation in `ContentView`. Tip: `.formatted()` for thousands separators.
- [ ] Lesson 2: colors in the asset catalog (you add the palette)
- [ ] Lesson 3: first view, `HomeView` layout (VStack/HStack/ZStack)
- [ ] Lesson 4: model `GameMode` (enum, switch, computed properties)
- [ ] Lesson 5: reusable component `ModeCard` (struct with inputs)
- [ ] Lesson 6: reusable style (`ViewModifier`) for the chunky outline + lip
- [ ] Lesson 7: custom fonts (Info.plist `UIAppFonts`, `Font.custom(_:size:relativeTo:)`)
- [ ] Later: tabs, game screen, map, data JSON, audio/video, animations, persistence

## Session notes
### 2026-10-26
- Claude got ahead and generated a full Home screen. You stopped it; code was removed (backup kept outside the repo). We restart with the step-by-step method above.
