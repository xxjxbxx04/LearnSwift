import SwiftUI

struct HomeView: View {
    @StateObject private var progress = ProgressManager.shared
    @State private var showReset = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Hero Banner
                    heroBanner

                    // Progress Card
                    progressCard

                    // Lesson List
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Lessons")
                            .font(.title2.bold())
                            .padding(.horizontal)

                        ForEach(LessonData.all) { lesson in
                            NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                                LessonRow(lesson: lesson, isCompleted: progress.isCompleted(lesson.id))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("LearnSwift")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") { showReset = true }
                        .foregroundColor(.red)
                }
            }
            .confirmationDialog("Reset all progress?", isPresented: $showReset, titleVisibility: .visible) {
                Button("Reset Progress", role: .destructive) { progress.reset() }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will clear all completed lessons.")
            }
        }
    }

    // MARK: Hero Banner
    private var heroBanner: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 8) {
                Text("🚀")
                    .font(.system(size: 50))
                Text("Learn Swift")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Text("8 beginner-friendly lessons")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.vertical, 30)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: Progress Card
    private var progressCard: some View {
        VStack(spacing: 10) {
            HStack {
                Label("Your Progress", systemImage: "chart.bar.fill")
                    .font(.headline)
                Spacer()
                Text("\(progress.totalCompleted) / \(progress.totalLessons)")
                    .font(.subheadline.monospacedDigit())
                    .foregroundColor(.secondary)
            }
            ProgressView(value: progress.progressFraction)
                .tint(progress.progressFraction == 1.0 ? .green : .blue)
            if progress.progressFraction == 1.0 {
                Label("All lessons complete! 🎉", systemImage: "checkmark.seal.fill")
                    .font(.footnote.bold())
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

// MARK: - Lesson Row
private struct LessonRow: View {
    let lesson: Lesson
    let isCompleted: Bool

    var body: some View {
        HStack(spacing: 14) {
            // Emoji icon
            ZStack {
                Circle()
                    .fill(isCompleted ? Color.green.opacity(0.15) : Color.blue.opacity(0.1))
                    .frame(width: 52, height: 52)
                Text(lesson.emoji)
                    .font(.title2)
            }

            // Title & subtitle
            VStack(alignment: .leading, spacing: 3) {
                Text(lesson.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(lesson.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                HStack(spacing: 6) {
                    difficultyBadge
                    Label("\(lesson.estimatedMinutes) min", systemImage: "clock")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            // Completion checkmark
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }

    private var difficultyBadge: some View {
        Text(lesson.difficulty.rawValue)
            .font(.caption2.bold())
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(lesson.difficulty == .beginner ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
            .foregroundColor(lesson.difficulty == .beginner ? .green : .orange)
            .clipShape(Capsule())
    }
}

#Preview {
    HomeView()
}
