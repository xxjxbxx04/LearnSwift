import SwiftUI

struct HomeView: View {
    @StateObject private var progress = ProgressManager.shared
    @State private var expandedSections: Set<Int> = [1]
    @State private var showReset = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    heroBanner
                    overallProgressCard

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Curriculum")
                            .font(.title2.bold())
                            .padding(.horizontal)

                        ForEach(LessonData.sections) { section in
                            SectionAccordion(
                                section: section,
                                isExpanded: expandedSections.contains(section.id),
                                progress: progress
                            ) {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    if expandedSections.contains(section.id) {
                                        expandedSections.remove(section.id)
                                    } else {
                                        expandedSections.insert(section.id)
                                    }
                                }
                            }
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
                    Button("Reset", role: .destructive) { showReset = true }
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
                colors: [.blue, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 8) {
                Text("🚀")
                    .font(.system(size: 50))
                Text("Learn Swift")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Text("32 lessons · 6 sections · Everything you need")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 28)
            .padding(.horizontal)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: Overall Progress Card
    private var overallProgressCard: some View {
        VStack(spacing: 12) {
            HStack {
                Label("Overall Progress", systemImage: "chart.bar.fill")
                    .font(.headline)
                Spacer()
                Text("\(progress.totalCompleted) / \(progress.totalLessons) lessons")
                    .font(.subheadline.monospacedDigit())
                    .foregroundColor(.secondary)
            }

            ProgressView(value: progress.progressFraction)
                .tint(progress.progressFraction == 1.0 ? .green : .blue)

            // Section chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(LessonData.sections) { section in
                        let done = section.lessons.filter { progress.isCompleted($0.id) }.count
                        let total = section.lessons.count
                        SectionChip(emoji: section.emoji, done: done, total: total)
                    }
                }
            }

            if progress.progressFraction == 1.0 {
                Label("All 32 lessons complete! You know Swift! 🎉", systemImage: "checkmark.seal.fill")
                    .font(.footnote.bold())
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

// MARK: - Section Chip
private struct SectionChip: View {
    let emoji: String
    let done: Int
    let total: Int

    private var isComplete: Bool { done == total }

    var body: some View {
        HStack(spacing: 4) {
            Text(emoji).font(.caption)
            Text("\(done)/\(total)")
                .font(.caption2.monospacedDigit())
                .foregroundColor(isComplete ? .green : .secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(isComplete ? Color.green.opacity(0.12) : Color(.tertiarySystemBackground))
        .clipShape(Capsule())
    }
}

// MARK: - Section Accordion
private struct SectionAccordion: View {
    let section: LessonSection
    let isExpanded: Bool
    @ObservedObject var progress: ProgressManager
    let toggle: () -> Void

    private var completedCount: Int {
        section.lessons.filter { progress.isCompleted($0.id) }.count
    }
    private var isAllDone: Bool { completedCount == section.lessons.count }

    var body: some View {
        VStack(spacing: 0) {
            // Header button
            Button(action: toggle) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(isAllDone ? Color.green.opacity(0.15) : Color.blue.opacity(0.1))
                            .frame(width: 46, height: 46)
                        Text(section.emoji).font(.title3)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(section.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("\(completedCount)/\(section.lessons.count) complete")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    if isAllDone {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: isExpanded ? 0 : 16))
            }
            .buttonStyle(.plain)

            // Expanded lesson list
            if isExpanded {
                VStack(spacing: 0) {
                    Divider().padding(.horizontal)

                    Text(section.description)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(section.lessons) { lesson in
                        NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                            CompactLessonRow(lesson: lesson, isCompleted: progress.isCompleted(lesson.id))
                        }
                        .buttonStyle(.plain)

                        if lesson.id != section.lessons.last?.id {
                            Divider().padding(.horizontal)
                        }
                    }
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 0))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

// MARK: - Compact Lesson Row
private struct CompactLessonRow: View {
    let lesson: Lesson
    let isCompleted: Bool

    var body: some View {
        HStack(spacing: 12) {
            Text(lesson.emoji)
                .font(.title3)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 2) {
                Text(lesson.title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.primary)
                HStack(spacing: 6) {
                    difficultyBadge
                    Label("\(lesson.estimatedMinutes) min", systemImage: "clock")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.body)
            } else {
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

    private var difficultyBadge: some View {
        let color: Color = {
            switch lesson.difficulty {
            case .beginner:     return .green
            case .intermediate: return .orange
            case .advanced:     return .red
            }
        }()
        return Text(lesson.difficulty.rawValue)
            .font(.caption2.bold())
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(color.opacity(0.12))
            .foregroundColor(color)
            .clipShape(Capsule())
    }
}

#Preview {
    HomeView()
}
