import Foundation

class BookmarkManager: ObservableObject {
    static let shared = BookmarkManager()

    @Published private(set) var bookmarkedLessonIDs: Set<Int> = []
    @Published private(set) var bookmarkedTermNames: Set<String> = []

    private let lessonKey = "bookmarkedLessonIDs"
    private let termKey   = "bookmarkedTermNames"

    private init() {
        if let saved = UserDefaults.standard.array(forKey: lessonKey) as? [Int] {
            bookmarkedLessonIDs = Set(saved)
        }
        if let saved = UserDefaults.standard.array(forKey: termKey) as? [String] {
            bookmarkedTermNames = Set(saved)
        }
    }

    // MARK: - Lessons

    func toggleLesson(_ id: Int) {
        if bookmarkedLessonIDs.contains(id) {
            bookmarkedLessonIDs.remove(id)
        } else {
            bookmarkedLessonIDs.insert(id)
        }
        saveLessons()
    }

    func isLessonBookmarked(_ id: Int) -> Bool {
        bookmarkedLessonIDs.contains(id)
    }

    var bookmarkedLessons: [Lesson] {
        LessonData.all.filter { bookmarkedLessonIDs.contains($0.id) }
    }

    private func saveLessons() {
        UserDefaults.standard.set(Array(bookmarkedLessonIDs), forKey: lessonKey)
    }

    // MARK: - Terms

    func toggleTerm(_ name: String) {
        if bookmarkedTermNames.contains(name) {
            bookmarkedTermNames.remove(name)
        } else {
            bookmarkedTermNames.insert(name)
        }
        saveTerms()
    }

    func isTermBookmarked(_ name: String) -> Bool {
        bookmarkedTermNames.contains(name)
    }

    var bookmarkedTerms: [GlossaryTerm] {
        GlossaryTerm.all.filter { bookmarkedTermNames.contains($0.term) }
    }

    private func saveTerms() {
        UserDefaults.standard.set(Array(bookmarkedTermNames), forKey: termKey)
    }

    // MARK: - Reset

    func reset() {
        bookmarkedLessonIDs = []
        bookmarkedTermNames = []
        UserDefaults.standard.removeObject(forKey: lessonKey)
        UserDefaults.standard.removeObject(forKey: termKey)
    }
}
