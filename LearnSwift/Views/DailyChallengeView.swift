import SwiftUI

struct DailyChallengeView: View {
    @StateObject private var streak = StreakManager.shared
    @Environment(\.dismiss) private var dismiss

    @AppStorage("lastChallengeIndex") private var lastChallengeIndex: Int = -1

    @State private var selectedAnswer: Int? = nil
    @State private var showResult: Bool = false
    @State private var alreadyCompleted: Bool = false

    private let challenge = DailyChallengeData.today

    private var isCorrect: Bool {
        selectedAnswer == challenge.correctIndex
    }

    // MARK: Body

    var body: some View {
        NavigationStack {
            Group {
                if alreadyCompleted {
                    celebrationView
                } else {
                    challengeView
                }
            }
            .navigationTitle("Daily Challenge")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .onAppear {
            alreadyCompleted = lastChallengeIndex == DailyChallengeData.todayIndex
        }
    }

    // MARK: Challenge View

    private var challengeView: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header card
                headerCard

                // Streak reminder
                streakReminder

                // Question card
                questionCard

                // Answer options
                VStack(spacing: 10) {
                    ForEach(Array(challenge.options.enumerated()), id: \.offset) { index, option in
                        ChallengeAnswerButton(
                            text: option,
                            index: index,
                            selectedAnswer: selectedAnswer,
                            correctIndex: challenge.correctIndex,
                            isRevealed: showResult
                        ) {
                            if selectedAnswer == nil {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedAnswer = index
                                    showResult = true
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // Explanation + next button
                if showResult {
                    explanationCard
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))

                    markDoneButton
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                        .transition(.opacity)
                }
            }
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
        .animation(.easeInOut(duration: 0.3), value: showResult)
    }

    // MARK: Header Card

    private var headerCard: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 6) {
                Text(formattedDate)
                    .font(.caption.bold())
                    .foregroundColor(.white.opacity(0.8))
                    .tracking(1)

                Text("Daily Challenge")
                    .font(.title2.bold())
                    .foregroundColor(.white)

                difficultyBadge
            }
            .padding(.vertical, 22)
            .padding(.horizontal)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }

    private var difficultyBadge: some View {
        let color: Color = {
            switch challenge.difficulty.lowercased() {
            case "easy":   return .green
            case "medium": return .orange
            case "hard":   return .red
            default:       return .white
            }
        }()
        return Text(challenge.difficulty)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color.white.opacity(0.2))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(color.opacity(0.8), lineWidth: 1.5)
            )
    }

    // MARK: Streak Reminder

    private var streakReminder: some View {
        HStack {
            Text("🔥 Day \(streak.currentStreak)")
                .font(.subheadline.bold())
                .foregroundColor(.orange)
            Spacer()
            Text("Keep it going!")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.orange.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    // MARK: Question Card

    private var questionCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Question", systemImage: "questionmark.circle.fill")
                .font(.caption.bold())
                .foregroundColor(.blue)

            Text(challenge.question)
                .font(.title3.bold())
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }

    // MARK: Explanation Card

    private var explanationCard: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "lightbulb.fill")
                .foregroundColor(isCorrect ? .green : .orange)
                .font(.title3)

            VStack(alignment: .leading, spacing: 4) {
                Text(isCorrect ? "Correct!" : "Not quite...")
                    .font(.headline)
                    .foregroundColor(isCorrect ? .green : .orange)
                Text(challenge.explanation)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background((isCorrect ? Color.green : Color.orange).opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke((isCorrect ? Color.green : Color.orange).opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: Mark Done Button

    private var markDoneButton: some View {
        Button {
            markCompleted()
        } label: {
            HStack {
                Image(systemName: "checkmark.seal.fill")
                Text("Mark Complete & Close")
                    .fontWeight(.bold)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isCorrect ? Color.green : Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }

    // MARK: Celebration View

    private var celebrationView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer(minLength: 40)

                Text("🎉")
                    .font(.system(size: 72))

                Text("Challenge Complete!")
                    .font(.largeTitle.bold())

                Text("You've already completed today's challenge.\nCome back tomorrow for a new one!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Streak display
                HStack(spacing: 20) {
                    VStack(spacing: 4) {
                        Text("🔥")
                            .font(.title)
                        Text("\(streak.currentStreak)")
                            .font(.title2.bold().monospacedDigit())
                        Text("Day Streak")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)

                    Divider().frame(height: 50)

                    VStack(spacing: 4) {
                        Text("⭐")
                            .font(.title)
                        Text("\(streak.longestStreak)")
                            .font(.title2.bold().monospacedDigit())
                        Text("Best Streak")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                .padding(.bottom, 40)

                Spacer()
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: Helpers

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: Date()).uppercased()
    }

    private func markCompleted() {
        lastChallengeIndex = DailyChallengeData.todayIndex
        StreakManager.shared.checkIn()
        withAnimation {
            alreadyCompleted = true
        }
    }
}

// MARK: - Challenge Answer Button

private struct ChallengeAnswerButton: View {
    let text: String
    let index: Int
    let selectedAnswer: Int?
    let correctIndex: Int
    let isRevealed: Bool
    let action: () -> Void

    private var backgroundColor: Color {
        guard isRevealed else {
            return selectedAnswer == index
                ? Color.blue.opacity(0.15)
                : Color(.secondarySystemGroupedBackground)
        }
        if index == correctIndex { return Color.green.opacity(0.2) }
        if selectedAnswer == index { return Color.red.opacity(0.2) }
        return Color(.secondarySystemGroupedBackground)
    }

    private var borderColor: Color {
        guard isRevealed else {
            return selectedAnswer == index ? .blue : Color(.separator)
        }
        if index == correctIndex { return .green }
        if selectedAnswer == index { return .red }
        return Color(.separator)
    }

    private var indexLabel: String {
        ["A", "B", "C", "D"][safe: index] ?? "\(index + 1)"
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Index circle
                Text(indexLabel)
                    .font(.caption.bold())
                    .frame(width: 28, height: 28)
                    .background(borderColor.opacity(0.2))
                    .foregroundColor(borderColor == Color(.separator) ? .secondary : borderColor)
                    .clipShape(Circle())

                // Option text
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()

                // Feedback icon after reveal
                if isRevealed {
                    if index == correctIndex {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else if selectedAnswer == index {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding()
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor.opacity(isRevealed ? 0.8 : 0.4), lineWidth: 1.5)
            )
        }
        .disabled(isRevealed)
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isRevealed)
    }
}

// MARK: - Safe Array Subscript

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    DailyChallengeView()
}
