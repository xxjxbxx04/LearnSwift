import Foundation

class StreakManager: ObservableObject {
    static let shared = StreakManager()

    @Published private(set) var currentStreak: Int = 0
    @Published private(set) var longestStreak: Int = 0

    private var lastOpenDate: Date? {
        get {
            guard let s = UserDefaults.standard.string(forKey: "streakLastDate") else { return nil }
            return ISO8601DateFormatter().date(from: s)
        }
        set {
            UserDefaults.standard.set(newValue.map { ISO8601DateFormatter().string(from: $0) }, forKey: "streakLastDate")
        }
    }

    private init() {
        currentStreak = UserDefaults.standard.integer(forKey: "streakCurrent")
        longestStreak = UserDefaults.standard.integer(forKey: "streakLongest")
    }

    func checkIn() {
        let cal   = Calendar.current
        let today = cal.startOfDay(for: Date())
        if let last = lastOpenDate {
            if cal.isDate(last, inSameDayAs: today) {
                return // already checked in today
            }
            let yesterday = cal.date(byAdding: .day, value: -1, to: today)!
            if cal.isDate(last, inSameDayAs: yesterday) {
                currentStreak += 1
            } else {
                currentStreak = 1
            }
        } else {
            currentStreak = 1
        }
        longestStreak = max(longestStreak, currentStreak)
        lastOpenDate  = today
        UserDefaults.standard.set(currentStreak, forKey: "streakCurrent")
        UserDefaults.standard.set(longestStreak,  forKey: "streakLongest")
    }

    func reset() {
        currentStreak = 0; longestStreak = 0; lastOpenDate = nil
        UserDefaults.standard.removeObject(forKey: "streakCurrent")
        UserDefaults.standard.removeObject(forKey: "streakLongest")
        UserDefaults.standard.removeObject(forKey: "streakLastDate")
    }

    var hasStreakToday: Bool {
        guard let last = lastOpenDate else { return false }
        return Calendar.current.isDate(last, inSameDayAs: Date())
    }
}
