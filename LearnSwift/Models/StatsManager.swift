import Foundation

class StatsManager: ObservableObject {
    static let shared = StatsManager()

    @Published private(set) var totalQuizzesTaken: Int = 0
    @Published private(set) var totalCorrectAnswers: Int = 0
    @Published private(set) var totalQuestionsAnswered: Int = 0

    private init() {
        totalQuizzesTaken       = UserDefaults.standard.integer(forKey: "statsTotalQuizzes")
        totalCorrectAnswers     = UserDefaults.standard.integer(forKey: "statsTotalCorrect")
        totalQuestionsAnswered  = UserDefaults.standard.integer(forKey: "statsTotalAnswered")
    }

    func recordQuiz(correct: Int, total: Int) {
        totalQuizzesTaken      += 1
        totalCorrectAnswers    += correct
        totalQuestionsAnswered += total
        UserDefaults.standard.set(totalQuizzesTaken,      forKey: "statsTotalQuizzes")
        UserDefaults.standard.set(totalCorrectAnswers,    forKey: "statsTotalCorrect")
        UserDefaults.standard.set(totalQuestionsAnswered, forKey: "statsTotalAnswered")
    }

    var accuracyPercent: Double {
        guard totalQuestionsAnswered > 0 else { return 0 }
        return (Double(totalCorrectAnswers) / Double(totalQuestionsAnswered)) * 100
    }

    var estimatedMinutesLearned: Int {
        let completedIDs = ProgressManager.shared.completedLessonIDs
        return LessonData.all
            .filter { completedIDs.contains($0.id) }
            .reduce(0) { $0 + $1.estimatedMinutes }
    }

    func reset() {
        totalQuizzesTaken      = 0
        totalCorrectAnswers    = 0
        totalQuestionsAnswered = 0
        UserDefaults.standard.removeObject(forKey: "statsTotalQuizzes")
        UserDefaults.standard.removeObject(forKey: "statsTotalCorrect")
        UserDefaults.standard.removeObject(forKey: "statsTotalAnswered")
    }
}
