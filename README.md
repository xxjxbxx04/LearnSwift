# LearnSwift 🚀

A **complete** beginner-to-advanced iOS app for learning Swift programming, built entirely with SwiftUI. No experience needed.

## 32 Lessons across 6 Sections

### 📗 Section 1 – Swift Basics
| # | Lesson | Topics Covered |
|---|--------|---------------|
| 1 | Variables & Constants | `var`, `let`, type inference |
| 2 | Data Types | `Int`, `Double`, `String`, `Bool`, interpolation |
| 3 | Control Flow | `if/else`, comparison operators, `switch` |
| 4 | Loops | `for-in`, `while`, `repeat-while`, `break`, `continue` |
| 5 | Functions | `func`, return values, argument labels, defaults |
| 6 | Arrays & Dictionaries | Collections, `.append()`, `.filter()`, `.map()` |
| 7 | Optionals | `?`, `if let`, `guard let`, `??`, optional chaining |
| 8 | Structs & Classes | Value vs reference types, `init` |

### 🔧 Section 2 – Types, Strings & Operators
| # | Lesson | Topics Covered |
|---|--------|---------------|
| 9  | Strings In-Depth | `.uppercased()`, `.split()`, `String(format:)` |
| 10 | Tuples | Named/unnamed tuples, decomposition, `_` |
| 11 | All About Operators | Arithmetic, logical, ternary, range operators |
| 12 | Sets | `Set<T>`, union, intersection, subtracting |
| 13 | Enumerations | Raw values, associated values, `CaseIterable` |
| 14 | Closures | Syntax, trailing closures, `$0`, map/filter/reduce |

### 🏛️ Section 3 – Object-Oriented Swift
| # | Lesson | Topics Covered |
|---|--------|---------------|
| 15 | Inheritance | Subclassing, `override`, `super`, `final` |
| 16 | Initialization | Designated, convenience, failable `init?`, `deinit` |
| 17 | Properties Deep Dive | Computed, `willSet`/`didSet`, `lazy`, `static` |
| 18 | Methods & Subscripts | Instance vs type methods, `mutating`, subscripts |
| 19 | Access Control | `private`, `fileprivate`, `internal`, `public`, `open` |
| 20 | Extensions | Extending any type, protocol conformance in extensions |

### 📋 Section 4 – Protocol-Oriented Programming
| # | Lesson | Topics Covered |
|---|--------|---------------|
| 21 | Protocols | Defining protocols, `Equatable`, `Codable`, `Hashable` |
| 22 | Protocol Extensions | Default implementations, protocol composition `&` |
| 23 | Generics | `<T>`, generic types, type constraints |
| 24 | Error Handling | `throws`, `do-catch`, `try?`, `Result<T,E>` |

### 🚀 Section 5 – Advanced Swift
| # | Lesson | Topics Covered |
|---|--------|---------------|
| 25 | Type Casting | `is`, `as?`, `as!`, `Any`, `AnyObject` |
| 26 | Memory Management | ARC, `weak`, `unowned`, retain cycles, `[weak self]` |
| 27 | Concurrency | `async`/`await`, `Task`, `@MainActor` |
| 28 | Higher-Order Functions | `map`, `compactMap`, `filter`, `reduce`, `flatMap`, `zip` |

### 📱 Section 6 – SwiftUI Fundamentals
| # | Lesson | Topics Covered |
|---|--------|---------------|
| 29 | Your First SwiftUI Views | `Text`, `Image`, `VStack`/`HStack`/`ZStack`, modifiers |
| 30 | State & Data Flow | `@State`, `@Binding`, `@StateObject`, `@Published` |
| 31 | Navigation & Lists | `NavigationStack`, `List`, `ForEach`, sheets, alerts |
| 32 | Forms & User Input | `TextField`, `Toggle`, `Slider`, `Picker`, `DatePicker`, `Form` |

---

## App Features

- **32 lessons** covering Swift from zero to advanced
- **Interactive quizzes** at the end of every lesson (60% to pass)
- **Section-based progress** — see how far you've come in each chapter
- **Expandable sections** — collapse chapters you've finished
- **Code examples** with a copy button in every lesson
- **Persistent progress** — your completions survive app restarts
- Supports iPhone and iPad

## Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

## Getting Started

1. Open `LearnSwift.xcodeproj` on your Desktop in Xcode
2. Select an iPhone simulator (e.g. iPhone 15)
3. Press **Cmd + R** to build and run
4. Start with Lesson 1 and work your way through!

## Project Structure

```
LearnSwift/
├── LearnSwiftApp.swift          # App entry point
├── ContentView.swift            # Root view
├── ProgressManager.swift        # Lesson completion & persistence
├── Models/
│   ├── Lesson.swift             # Data models (Lesson, LessonSection, etc.)
│   └── LessonData.swift         # All 32 lessons & 6 sections of content
└── Views/
    ├── HomeView.swift            # Curriculum overview with section accordion
    ├── LessonDetailView.swift    # Lesson content with code examples
    └── QuizView.swift            # Interactive quiz with explanations
```
