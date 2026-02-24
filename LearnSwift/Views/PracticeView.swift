import SwiftUI

struct PracticeView: View {
    @StateObject private var streak = StreakManager.shared
    @StateObject private var stats = StatsManager.shared
    @StateObject private var progress = ProgressManager.shared

    @AppStorage("lastChallengeIndex") private var lastChallengeIndex: Int = -1

    private var isChallengeCompleted: Bool {
        lastChallengeIndex == DailyChallengeData.todayIndex
    }

    // Group FlashcardData.all by category, preserving first-seen order
    private var categories: [(name: String, cards: [Flashcard])] {
        var seen: [String] = []
        var map: [String: [Flashcard]] = [:]
        for card in FlashcardData.all {
            if map[card.category] == nil {
                seen.append(card.category)
                map[card.category] = []
            }
            map[card.category]!.append(card)
        }
        return seen.map { (name: $0, cards: map[$0]!) }
    }

    private let categoryEmojis: [String: String] = [
        "Basics": "📗",
        "Control Flow": "🚦",
        "Functions": "⚙️",
        "Closures": "🔒",
        "Collections": "📚",
        "OOP": "🏛️",
        "Protocols": "📋",
        "SwiftUI": "📱",
        "Concurrency": "⚡",
        "Error Handling": "🛡️",
        "Generics": "🧬",
        "Memory": "🧠",
    ]

    private func emoji(for category: String) -> String {
        categoryEmojis[category] ?? "📦"
    }

    private let twoColumnGrid = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    headerBanner
                    dailyChallengeCard
                    flashcardsSection
                    statsRow
                }
                .padding(.bottom, 30)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Practice")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: Header Banner

    private var headerBanner: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 8) {
                Text("🎯")
                    .font(.system(size: 44))
                Text("Practice")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Text("Test your Swift knowledge")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.vertical, 28)
            .padding(.horizontal)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: Daily Challenge Card

    private var dailyChallengeCard: some View {
        let challenge = DailyChallengeData.today
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                Label("Daily Challenge", systemImage: "calendar.badge.clock")
                    .font(.headline)
                Spacer()
                if isChallengeCompleted {
                    completedBadge
                } else {
                    difficultyBadge(challenge.difficulty)
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)

            Divider().padding(.horizontal)

            Text(challenge.question)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .padding()

            NavigationLink(destination: DailyChallengeView()) {
                HStack {
                    Text(isChallengeCompleted ? "Review Challenge" : "Start Challenge")
                        .font(.subheadline.bold())
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                }
                .padding()
                .background(
                    LinearGradient(
                        colors: isChallengeCompleted
                            ? [Color.green.opacity(0.15), Color.green.opacity(0.08)]
                            : [Color.blue.opacity(0.12), Color.indigo.opacity(0.08)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(isChallengeCompleted ? .green : .blue)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .padding([.horizontal, .bottom])
            }
            .buttonStyle(.plain)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }

    private var completedBadge: some View {
        Label("Completed Today", systemImage: "checkmark.circle.fill")
            .font(.caption.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.green.opacity(0.12))
            .foregroundColor(.green)
            .clipShape(Capsule())
    }

    private func difficultyBadge(_ difficulty: String) -> some View {
        let color: Color = {
            switch difficulty.lowercased() {
            case "easy":   return .green
            case "medium": return .orange
            case "hard":   return .red
            default:       return .blue
            }
        }()
        return Text(difficulty)
            .font(.caption.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.12))
            .foregroundColor(color)
            .clipShape(Capsule())
    }

    // MARK: Flashcards Section

    private var flashcardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Flashcards")
                    .font(.title2.bold())
                Spacer()
                NavigationLink(destination: FlashcardDeckView(category: nil)) {
                    Text("All Cards")
                        .font(.subheadline.bold())
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            LazyVGrid(columns: twoColumnGrid, spacing: 12) {
                ForEach(categories, id: \.name) { item in
                    NavigationLink(destination: FlashcardDeckView(category: item.name)) {
                        CategoryCard(
                            name: item.name,
                            count: item.cards.count,
                            emoji: emoji(for: item.name)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }

    // MARK: Stats Row

    private var statsRow: some View {
        HStack(spacing: 0) {
            StatPill(
                icon: "flame.fill",
                iconColor: .orange,
                value: "\(streak.currentStreak)",
                label: "Day Streak"
            )
            Divider()
                .frame(height: 36)
            StatPill(
                icon: "checkmark.circle.fill",
                iconColor: .green,
                value: stats.totalQuestionsAnswered > 0
                    ? "\(Int(stats.accuracyPercent))%"
                    : "—",
                label: "Accuracy"
            )
            Divider()
                .frame(height: 36)
            StatPill(
                icon: "book.closed.fill",
                iconColor: .blue,
                value: "\(progress.totalCompleted)",
                label: "Lessons Done"
            )
        }
        .padding(.vertical, 14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

// MARK: - Category Card

private struct CategoryCard: View {
    let name: String
    let count: Int
    let emoji: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(emoji)
                    .font(.title2)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.subheadline.bold())
                    .foregroundColor(.primary)
                    .lineLimit(2)
                Text("\(count) cards")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 96, alignment: .topLeading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator).opacity(0.5), lineWidth: 0.5)
        )
    }
}

// MARK: - Stat Pill

private struct StatPill: View {
    let icon: String
    let iconColor: Color
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.body)
            Text(value)
                .font(.title3.bold().monospacedDigit())
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PracticeView()
}
