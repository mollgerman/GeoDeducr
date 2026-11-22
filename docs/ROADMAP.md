# GeoDeducr: finish plan (4 lab classes)

**Written:** 17 Nov 2026, updated the same day to follow the lecture slides.
**Scope:** `docs/GeoDeducr/IOS_288388_GeoDeducr_2026.pdf` (Module 1 design, 8 screens). **Rules:** `docs/PROFESSOR_RULES.md` (lectures W2–W5). Check every class's work against it.
**Rhythm:** labs on the Mac = **UI in Xcode**. Home on Windows = **plain Swift** (models, rules, checks in swiftfiddle.com) and **collecting media**.
★ = needed for the course requirements. If time runs short, use the "Cut list" in its order (item 1 first).

---

## Before class 1 (home, Windows)
- [ ] Fill in TODOs 1–4 in the model exercise (skip TODO 5: guessing becomes pin-based)
- [ ] Bring an **iPhone + cable** to class 1 (★ app must run on a device)

## Class 1 · Project structure + App shell + Home ★
| Step | What | Rule / source |
|---|---|---|
| 1.1 | Commit local work on the lab Mac → **Integrate → Pull**. Add `.gitignore` (`xcuserdata/`, `DerivedData/`, `.DS_Store`) and stop tracking `xcuserdata` | W4 Git |
| 1.2 | Folders **Models / ViewModels / Views (+ Components) / Services / Utils / Resources**. **One type per file**. Rename `MyApp` → `GeoDeducrApp`, `ContentView` → `MainView` | W4 rules + folders |
| 1.3 | Theme: the 4 missing font styles. Commit `ModeCard.swift` into `Views/Components/` | W4 Text |
| 1.4 | `extension GameMode { fill, lip, textColor }` → `HomeView` uses `ForEach(GameMode.allCases)` | W5 enums |
| 1.5 | `HomeView` layout: sky gradient, ground, logo, wooden board, total score. Keep `body` small: split into subviews | W4 small views |
| 1.6 | `MainView` = `TabView` with `Tab("Home", systemImage: "house.fill")`, Passport, Settings (placeholders) | W4 TabView |
| 1.7 | Tap a mode card → `fullScreenCover` with a placeholder `GameView` (`@State`) | W4 Views and state |
| 1.8 | ★ Run on your iPhone once (Developer Mode). Check the smallest and largest simulators | W4, W2 |

**Homework A (Windows):**
- Models for **pin guessing**, one type per file: `City` (`Codable`: name, country, latitude, longitude, timeZone, photo, helloAudio, funFact, clues), `Clue` (enum of the 5 clue types), `RoundResult`. Score = clue max − distance penalty (full points within 25 km; you pick the formula).
- `cities.json` with **15 cities** (★ 15 photos).
- Collect media **by the W3 rules**: photos from Wikimedia Commons / Openverse / Unsplash / Pexels (no NC/ND, no recognizable people), strip GPS with `exiftool -all=`; record your own "hello" clips with the phone. Start **`docs/CREDITS.md`** (Title, Author, Source, License, date) for every file.

## Class 2 · The game (MVVM) ★
| Step | What | Rule / source |
|---|---|---|
| 2.1 | `Services/CityService`: load `cities.json` from the bundle with `JSONDecoder`, `do/catch`, `Logger` (no `try!`) | W5 JSON, W4 Logger |
| 2.2 | `ViewModels/GameViewModel` (`@MainActor @Observable final class`): 5 random cities, current round, pin, unlocked clues, scores | W4/W5 MVVM |
| 2.3 | `Views/Game/GameView`: `Map` with country-level zoom (`MapCameraBounds`), tap to drop a pin (`MapReader`). The View only talks to the ViewModel | MapKit for SwiftUI |
| 2.4 | Clue panel (`presentationDetents`): newest clue, unlock next (−1,000), "Confirm guess" | — |
| 2.5 | `RoundResultView`: distance (`CLLocation.distance(from:)`), city photo (`.resizable().scaledToFill().clipShape(…)`), points, "Next round" | W5 Images |
| 2.6 | ★ The 15 photos in Assets | W5 Images |

**Homework B (Windows):** stars logic (5,000 / 12,000 / 20,000) and a timer model, with checks. ★ Tutorial video: record the app or your Figma prototype with **OBS**, cut it in iMovie/Shotcut, export H.264/HEVC MP4 (`tutorial.mp4`, ~30 s). Sound effects from Freesound (CC0/CC BY). Add every file to `CREDITS.md`.

## Class 3 · Full loop + multimedia + live data ★
| Step | What | Rule / source |
|---|---|---|
| 3.1 | `GameSummaryView`: stars, list of rounds, Play again, Home | — |
| 3.2 | Timed modes: countdown, clue auto-reveal, time-out = guess | W5 async |
| 3.3 | Pause overlay: blur + Resume / Restart / Quit (alert) | — |
| 3.4 | ★ `Services/SoundPlayer` (AVAudioPlayer): "hello" clue + sound effects | W3 audio |
| 3.5 | ★ Onboarding: paged `TabView`, `VideoPlayer` on page 1, shown once with `@AppStorage` | W3 video, W5 |
| 3.6 | ★ Animations: spinning globe on the splash, clue card flip, pin drop, `.symbolEffect` on icons | W5 SF Symbols |
| 3.7 | Live clue: `Services/WeatherService` (Open-Meteo, `URLSession` async, status check) with **loading / error states**. Without internet: local time from the time zone | W5 API + MVVM |

**Homework C:** draft the **Module 2 PDF**: folders and files (MVVM layers), which file covers each requirement, screen map, media credits.

## Class 4 · Passport, Settings, saving, delivery ★
| Step | What | Rule / source |
|---|---|---|
| 4.1 | Saving: **SwiftData** `@Model` for found cities + best scores; `@AppStorage` for settings and total score | W5 SwiftData |
| 4.2 | Passport: stats, stamp grid (`LazyVGrid`), Stamps/List `Picker`, **`NavigationStack` + `navigationDestination`** to City detail ("Hear hello" with `.symbolEffect(.wiggle)`). Empty passport → `ContentUnavailableView` | W4 List & navigation |
| 4.3 | Settings: `Form` (toggles, units, replay tutorial, reset with `confirmationDialog`) + **Acknowledgements** (media credits, font licenses) | W3 licenses |
| 4.4 | Polish: score counting up (`.contentTransition(.numericText())`), timer pulse, remove `#Playground` leftovers, check against `PROFESSOR_RULES.md` | W4 rules |
| 4.5 | ★ Reinstall on the iPhone (free Apple ID: valid 7 days), finish the PDF, zip **`IOS_288388_GeoDeducr_2026.zip`**, send via Teams | Course PDF, W4 |

**Module 3 (classes 13–14):** Swift Testing on `GameViewModel` (scoring, clue unlocking, stars), `⌘U`, screenshots of results for the test document.

---

## Cut list (only if behind; cut in this order, 1 first)
1. Daily challenge "same cities for everyone" (seed by date)
2. Share emoji grid (`ShareLink`)
3. Passport List view (keep only Stamps)
4. Pause blur, timer pulse
5. Live weather → local time only (keep `WeatherService` if possible: it shows the W5 API + MVVM pattern)

## Progress
| Class | Date | Done | Notes |
|---|---|---|---|
| Before 1 | | | |
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
