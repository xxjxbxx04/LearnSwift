import SwiftUI

struct QuizView: View {
    let lesson: Lesson
    @StateObject private var progress = ProgressManager.shared
    @Environment(\.dismiss) private var dismiss

    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showExplanation = false
    @State private var correctCount = 0
    @State private var isFinished = false

    private var currentQuestion: QuizQuestion { lesson.quiz[currentIndex] }
    private var totalQuestions: Int { lesson.quiz.count }
    private var passingScore: Int { Int(ceil(Double(totalQuestions) * 0.6)) }
    private var passed: Bool { correctCount >= passingScore }

    var body: some View {
        NavigationStack {
            Group {
                if isFinished {
                    resultsView
                } else {
                    questionView
                }
            }
            .navigationTitle("Quiz – \(lesson.title)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    // MARK: Question View
    private var questionView: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Progress bar
                VStack(spacing: 6) {
                    HStack {
                        Text("Question \(currentIndex + 1) of \(totalQuestions)")
                            .font(.subheadline.bold())
                        Spacer()
                        Text("\(correctCount) correct")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    ProgressView(value: Double(currentIndex), total: Double(totalQuestions))
                        .tint(.blue)
                }
                .padding(.horizontal)
                .padding(.top)

                // Question card
                VStack(alignment: .leading, spacing: 16) {
                    Text(currentQuestion.question)
                        .font(.title3.bold())
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                // Answer options
                VStack(spacing: 10) {
                    ForEach(Array(currentQuestion.options.enumerated()), id: \.offset) { index, option in
                        AnswerButton(
                            text: option,
                            index: index,
                            selectedAnswer: selectedAnswer,
                            correctIndex: currentQuestion.correctIndex,
                            isRevealed: showExplanation
                        ) {
                            if selectedAnswer == nil {
                                selectedAnswer = index
                                if index == currentQuestion.correctIndex { correctCount += 1 }
                                withAnimation { showExplanation = true }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // Explanation
                if showExplanation {
                    ExplanationCard(
                        isCorrect: selectedAnswer == currentQuestion.correctIndex,
                        explanation: currentQuestion.explanation
                    )
                    .padding(.horizontal)
                    .transition(.move(edge: .bottom).combined(with: .opacity))

                    Button(currentIndex + 1 < totalQuestions ? "Next Question →" : "See Results") {
                        advanceOrFinish()
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: Results View
    private var resultsView: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Trophy / X icon
                ZStack {
                    Circle()
                        .fill(passed ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
                        .frame(width: 100, height: 100)
                    Text(passed ? "🏆" : "📖")
                        .font(.system(size: 52))
                }
                .padding(.top, 40)

                Text(passed ? "Lesson Complete!" : "Keep Practicing")
                    .font(.largeTitle.bold())

                Text("\(correctCount) out of \(totalQuestions) correct")
                    .font(.title3)
                    .foregroundColor(.secondary)

                // Score bar
                VStack(spacing: 8) {
                    ProgressView(value: Double(correctCount), total: Double(totalQuestions))
                        .tint(passed ? .green : .red)
                        .scaleEffect(x: 1, y: 2)
                    HStack {
                        Text("0")
                        Spacer()
                        Text("Passing: \(passingScore)/\(totalQuestions)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(totalQuestions)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal, 32)

                if passed {
                    Label("Marked as complete!", systemImage: "checkmark.seal.fill")
                        .font(.headline)
                        .foregroundColor(.green)
                } else {
                    Text("You need \(passingScore)/\(totalQuestions) to pass. Review the lesson and try again!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Buttons
                VStack(spacing: 12) {
                    Button("Done") { dismiss() }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                    if !passed {
                        Button("Try Again") { restartQuiz() }
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.secondarySystemGroupedBackground))
                            .foregroundColor(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            if passed { progress.markCompleted(lesson.id) }
            StatsManager.shared.recordQuiz(correct: correctCount, total: totalQuestions)
        }
    }

    // MARK: Helpers
    private func advanceOrFinish() {
        if currentIndex + 1 < totalQuestions {
            withAnimation {
                currentIndex += 1
                selectedAnswer = nil
                showExplanation = false
            }
        } else {
            withAnimation { isFinished = true }
        }
    }

    private func restartQuiz() {
        currentIndex = 0
        selectedAnswer = nil
        showExplanation = false
        correctCount = 0
        withAnimation { isFinished = false }
    }
}

// MARK: - Answer Button
private struct AnswerButton: View {
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

    var body: some View {
        Button(action: action) {
            HStack {
                Text(indexLabel)
                    .font(.caption.bold())
                    .frame(width: 26, height: 26)
                    .background(borderColor.opacity(0.2))
                    .clipShape(Circle())
                    .foregroundColor(borderColor)
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
                if isRevealed {
                    if index == correctIndex {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                    } else if selectedAnswer == index {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                    }
                }
            }
            .padding()
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor.opacity(0.6), lineWidth: 1)
            )
        }
        .disabled(isRevealed)
        .buttonStyle(.plain)
    }

    private var indexLabel: String {
        ["A", "B", "C", "D"][safe: index] ?? "\(index)"
    }
}

// MARK: - Explanation Card
private struct ExplanationCard: View {
    let isCorrect: Bool
    let explanation: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "lightbulb.fill")
                .foregroundColor(isCorrect ? .green : .orange)
                .font(.title3)
            VStack(alignment: .leading, spacing: 4) {
                Text(isCorrect ? "Correct!" : "Not quite...")
                    .font(.headline)
                    .foregroundColor(isCorrect ? .green : .orange)
                Text(explanation)
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
}

// MARK: - Safe Array Subscript
private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    QuizView(lesson: LessonData.all[0])
}
