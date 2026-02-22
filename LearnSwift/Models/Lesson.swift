import Foundation

// MARK: - Lesson Section (groups lessons into chapters)

struct LessonSection: Identifiable {
    let id: Int
    let title: String
    let emoji: String
    let description: String
    let lessons: [Lesson]

    var completedCount: Int {
        lessons.filter { ProgressManager.shared.isCompleted($0.id) }.count
    }

    var isFullyComplete: Bool { completedCount == lessons.count }
}

// MARK: - Lesson Model

struct Lesson: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let emoji: String
    let difficulty: Difficulty
    let estimatedMinutes: Int
    let sections: [ContentSection]
    let quiz: [QuizQuestion]

    enum Difficulty: String {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }
}

// MARK: - Content Section

struct ContentSection: Identifiable {
    let id = UUID()
    let heading: String
    let body: String
    let codeExample: String?

    init(heading: String, body: String, codeExample: String? = nil) {
        self.heading = heading
        self.body = body
        self.codeExample = codeExample
    }
}

// MARK: - Quiz Question

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
}
