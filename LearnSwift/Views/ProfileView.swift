import SwiftUI

struct ProfileView: View {
    @StateObject private var streak = StreakManager.shared
    @StateObject private var stats = StatsManager.shared
    @StateObject private var progress = ProgressManager.shared
    @StateObject private var bookmarks = BookmarkManager.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    profileHeader

                    // Stats grid
                    statsGrid

                    // Bookmarked lessons
                    if !bookmarks.bookmarkedLessons.isEmpty {
                        bookmarkedLessonsSection
                    }

                    // Bookmarked terms
                    if !bookmarks.bookmarkedTerms.isEmpty {
                        bookmarkedTermsSection
                    }

                    // Empty bookmarks
                    if bookmarks.bookmarkedLessons.isEmpty && bookmarks.bookmarkedTerms.isEmpty {
                        emptyBookmarks
                    }
                }
                .padding(.bottom, 30)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Me")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: Header
    private var profileHeader: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 72, height: 72)
                    Text("🧑‍💻")
                        .font(.system(size: 40))
                }

                Text("Swift Learner")
                    .font(.title3.bold())
                    .foregroundColor(.white)

                HStack(spacing: 24) {
                    VStack(spacing: 2) {
                        Text("\(streak.currentStreak)")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        Text("day streak")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    Rectangle()
                        .fill(.white.opacity(0.3))
                        .frame(width: 1, height: 30)

                    VStack(spacing: 2) {
                        Text("\(progress.totalCompleted)")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        Text("lessons done")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    Rectangle()
                        .fill(.white.opacity(0.3))
                        .frame(width: 1, height: 30)

                    VStack(spacing: 2) {
                        Text("\(Int(stats.accuracyPercent))%")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        Text("accuracy")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.top, 4)
            }
            .padding(.vertical, 28)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: Stats Grid
    private var statsGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Stats")
                .font(.title3.bold())
                .padding(.horizontal)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                StatCard(icon: "flame.fill", iconColor: .orange, value: "\(streak.currentStreak)", label: "Current Streak", unit: "days")
                StatCard(icon: "trophy.fill", iconColor: .yellow, value: "\(streak.longestStreak)", label: "Longest Streak", unit: "days")
                StatCard(icon: "checkmark.circle.fill", iconColor: .green, value: "\(stats.totalQuizzesTaken)", label: "Quizzes Taken", unit: "total")
                StatCard(icon: "target", iconColor: .blue, value: "\(Int(stats.accuracyPercent))%", label: "Quiz Accuracy", unit: "avg")
                StatCard(icon: "book.fill", iconColor: .purple, value: "\(progress.totalCompleted)/\(progress.totalLessons)", label: "Lessons Done", unit: "progress")
                StatCard(icon: "clock.fill", iconColor: .teal, value: "\(stats.estimatedMinutesLearned)", label: "Minutes Learned", unit: "est.")
            }
            .padding(.horizontal)
        }
    }

    // MARK: Bookmarked Lessons
    private var bookmarkedLessonsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Saved Lessons")
                    .font(.title3.bold())
                Spacer()
                Text("\(bookmarks.bookmarkedLessons.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            VStack(spacing: 0) {
                ForEach(Array(bookmarks.bookmarkedLessons.enumerated()), id: \.element.id) { index, lesson in
                    NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                        HStack(spacing: 12) {
                            Text(lesson.emoji)
                                .font(.title3)
                                .frame(width: 36)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(lesson.title)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.primary)
                                Text(lesson.subtitle)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)

                    if index < bookmarks.bookmarkedLessons.count - 1 {
                        Divider().padding(.leading, 64)
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
        }
    }

    // MARK: Bookmarked Terms
    private var bookmarkedTermsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Saved Terms")
                    .font(.title3.bold())
                Spacer()
                Text("\(bookmarks.bookmarkedTerms.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            VStack(spacing: 0) {
                ForEach(Array(bookmarks.bookmarkedTerms.enumerated()), id: \.element.id) { index, term in
                    HStack(spacing: 12) {
                        Text(term.emoji)
                            .font(.title3)
                            .frame(width: 36)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(term.term)
                                .font(.subheadline.bold())
                                .foregroundColor(.primary)
                            Text(term.oneLiner)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    if index < bookmarks.bookmarkedTerms.count - 1 {
                        Divider().padding(.leading, 64)
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
        }
    }

    // MARK: Empty Bookmarks
    private var emptyBookmarks: some View {
        VStack(spacing: 16) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 40))
                .foregroundColor(.secondary.opacity(0.5))
            Text("No Saved Items Yet")
                .font(.headline)
                .foregroundColor(.primary)
            Text("Bookmark lessons and glossary terms to find them here quickly.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.vertical, 30)
    }
}

// MARK: - Stat Card
private struct StatCard: View {
    let icon: String
    let iconColor: Color
    let value: String
    let label: String
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.subheadline)
                Spacer()
                Text(unit)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Text(value)
                .font(.system(.title2, design: .rounded).bold())
                .foregroundColor(.primary)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ProfileView()
}
