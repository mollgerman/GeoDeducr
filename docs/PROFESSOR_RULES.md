# Professor's rules for GeoDeducr (from lectures W2–W5)

**Source:** mgr inż. Oleksandr Yeroshkin, *Mobile Applications for iOS*, lecture slides W2 (UI/UX), W3 (multimedia & copyright), W4 (implementation rules & app structure), W5 (Swift basics & core libraries). Read 17 Nov 2026.
**Use:** check every class's work against this list. Where Apple's docs and these slides differ, follow the slides.

---

## 1. Code rules (W4 "Implementation rules", W5 "Common beginner mistakes")
- [ ] **Clear names:** types `UpperCamelCase` (`HomeView`), variables `lowerCamelCase` (`totalScore`), Bools read as questions (`isPaused`, `hasPin`).
- [ ] **One type per file, file name = type name** (`ModeCard.swift` holds `struct ModeCard`).
- [ ] **Small views:** if `body` gets long, move parts into subviews.
- [ ] **`let` by default**, `var` only when the value changes.
- [ ] **No force unwrap `!` and no `try!`**: use `if let`, `guard let`, `??`, `do { } catch { }`.
- [ ] **`private` by default** for everything other files don't need.
- [ ] **Format:** Editor → Structure (swift-format), `⌃I` to re-indent.
- [ ] **Logger instead of `print()`** (`import OSLog`, levels debug / info / error).
- [ ] `#Preview` (not `PreviewProvider`) in every view file.
- [ ] Don't compare `Double` with `==`. Change array items by index, not via `for var`.

## 2. Architecture: MVVM (W4 Part 3, W5 Part 6)
- [ ] **View → ViewModel → Model.** The View never talks to the Model or a Service directly.
- [ ] ViewModel = `@MainActor @Observable final class`, held in the View with `@State private var viewModel = …`.
- [ ] Network / file loading lives in a **Service** (`async throws`), not in the View.
- [ ] Screens that load data show **4 states:** loading, error (with Retry), empty, data. Use `ContentUnavailableView` for error and empty states.
- [ ] Model = `struct` (value type); shared state = `class`. Use `enum` (with associated values) for screen states.
- [ ] `Codable` + `JSONDecoder` for JSON; optional properties for fields that can be missing.

**Folders: by layer** (W4 "Folders: by layer or by feature"; matches decision #5 in LEARNING_LOG):
```
GeoDeducr/
├── GeoDeducrApp.swift   (@main)
├── Models/              GameMode, City, Clue, RoundResult …
├── ViewModels/          GameViewModel, PassportViewModel …
├── Views/               MainView (TabView), Home/, Game/, Passport/, Settings/, Onboarding/
│   └── Components/      LogoView, ModeCard, ChunkyButton …
├── Services/            CityService (JSON), WeatherService (Open-Meteo), SoundPlayer
├── Utils/               Theme (fonts), Logger
└── Resources/           cities.json, tutorial.mp4, sounds
```

## 3. SwiftUI building blocks (W4 Part 2, W5 Part 4)
- [ ] **App → Scene → View:** `@main struct GeoDeducrApp: App` → `WindowGroup` → `MainView`.
- [ ] **TabView** with the `Tab("Home", systemImage: "house.fill") { … }` API. Tabs are for navigation, not actions; few tabs; one-word labels; filled SF Symbols; the tab bar stays visible.
- [ ] **NavigationStack** (never `NavigationView`, it's deprecated) + `NavigationLink(value:)` + `.navigationDestination(for:)` for list → detail (Passport → City detail).
- [ ] **Text:** text styles + Dynamic Type (our `Font.custom(…, relativeTo:)`), minimum 11 pt.
- [ ] **Images:** `.resizable()` first; `.scaledToFill()` + `.clipShape(.rect(cornerRadius:))` for photos; **icons = SF Symbols**, not image files; a tappable image is a Button.
- [ ] **SF Symbol animations:** `.symbolEffect(.bounce / .wiggle / .pulse, value:)` (e.g. the "Hear hello" speaker wiggle).
- [ ] **Saving:** small settings → `@AppStorage`; app data → **SwiftData** (`@Model`, `.modelContainer`, `@Query`).
- [ ] **async/await** + `.task { }` for loading; HTTPS only.

## 4. Media and copyright (W3)
- [ ] **Sources:** own recordings/photos (best), Openverse, Wikimedia Commons, Unsplash / Pexels / Pixabay (their own licenses: read them), Freesound (check each sound), Free Music Archive, NASA. **Never** download from YouTube, Spotify, SoundCloud and similar (App Store 5.2.3).
- [ ] **Avoid CC NC and ND** licenses. CC0 / CC BY / CC BY-SA are OK.
- [ ] **Keep `docs/CREDITS.md`:** Title, Author, Source link, License (TASL) + download date for every photo, sound and video. Also show credits in the app (Settings → Acknowledgements), together with font licenses.
- [ ] **Remove metadata (GPS)** from photos: `exiftool -all= photo.jpg`.
- [ ] **No recognizable people** in city photos without consent (GDPR / image rights). Landmarks, landscapes and crowds are fine.
- [ ] **Formats:** photos JPEG/HEIC, UI graphics PNG, final audio AAC (`.m4a`), video MP4 with H.264/HEVC (`ffmpeg -i in.mov -c:v libx265 -crf 28 -tag:v hvc1 -c:a aac out.mp4`).
- [ ] **Free tools:** OBS (screen recording for the tutorial video), iMovie, GarageBand / Audacity, GIMP / Krita, HandBrake / FFmpeg.
- [ ] **SF Symbols must not be used in the app icon.**
- [ ] Swift packages: only MIT / BSD / Apache 2.0, listed on the Acknowledgements screen. Add a `LICENSE` file to the repo.
- [ ] AI-generated media: avoid it, or label it.

## 5. Devices, testing, Git (W2, W4)
- [ ] Check layouts on the **smallest (iPhone 13 mini, 5.4") and largest (17/18 Pro Max, 6.9")** simulators.
- [ ] Real iPhone: Developer Mode on. **Free Apple ID = the app works for 7 days**, so reinstall from Xcode in the week of each assessment.
- [ ] Unit tests with **Swift Testing** on the ViewModels (`@Test`, `#expect`, `⌘U`), the reason we use MVVM. → Module 3.
- [ ] **Git:** pull before you start; small commits with "Add… / Fix… / Update…" messages; a branch per feature (`feature/home`); never commit passwords or keys.
- [ ] `.gitignore`: `xcuserdata/`, `DerivedData/`, `.DS_Store`.
- [ ] Shortcuts: ⌘R run, ⌘B build, ⌘U test, ⌥⌘P refresh preview, ⇧⌘O open quickly, ⌥⌘C commit.
