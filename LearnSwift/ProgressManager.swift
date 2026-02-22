import Foundation

// MARK: - Progress Manager
// Persists completed lessons using UserDefaults.

class ProgressManager: ObservableObject {
    static let shared = ProgressManager()

    @Published private(set) var completedLessonIDs: Set<Int> = []

    private let storageKey = "completedLessons"

    private init() { load() }

    func markCompleted(_ lessonID: Int) {
        completedLessonIDs.insert(lessonID)
        save()
    }

    func isCompleted(_ lessonID: Int) -> Bool {
        completedLessonIDs.contains(lessonID)
    }

    func reset() {
        completedLessonIDs.removeAll()
        UserDefaults.standard.removeObject(forKey: storageKey)
    }

    var totalCompleted: Int { completedLessonIDs.count }
    var totalLessons: Int { LessonData.all.count }
    var progressFraction: Double {
        guard totalLessons > 0 else { return 0 }
        return Double(totalCompleted) / Double(totalLessons)
    }

    private func save() {
        UserDefaults.standard.set(Array(completedLessonIDs), forKey: storageKey)
    }

    private func load() {
        if let saved = UserDefaults.standard.array(forKey: storageKey) as? [Int] {
            completedLessonIDs = Set(saved)
        }
    }
}
