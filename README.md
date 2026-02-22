# LearnSwift 🚀

A beginner-friendly iOS app for learning Swift programming, built with SwiftUI.

## Features

- **8 structured lessons** covering Swift fundamentals
- **Interactive quizzes** at the end of each lesson (pass 60% to complete)
- **Progress tracking** that persists between app launches
- **Copyable code examples** with syntax highlighting
- Supports both iPhone and iPad

## Lessons

| # | Topic | Difficulty |
|---|-------|------------|
| 1 | Variables & Constants | Beginner |
| 2 | Data Types | Beginner |
| 3 | Control Flow | Beginner |
| 4 | Loops | Beginner |
| 5 | Functions | Beginner |
| 6 | Arrays & Dictionaries | Beginner |
| 7 | Optionals | Intermediate |
| 8 | Structs & Classes | Intermediate |

## Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

## Getting Started

1. Open `LearnSwift.xcodeproj` in Xcode
2. Select an iPhone simulator or your device
3. Press **Cmd + R** to build and run

## Project Structure

```
LearnSwift/
├── LearnSwiftApp.swift       # App entry point
├── ContentView.swift         # Root view
├── ProgressManager.swift     # Lesson completion persistence
├── Models/
│   ├── Lesson.swift          # Data models
│   └── LessonData.swift      # All lesson content
└── Views/
    ├── HomeView.swift         # Lesson list + progress
    ├── LessonDetailView.swift # Lesson content + code examples
    └── QuizView.swift         # Interactive quiz
```
