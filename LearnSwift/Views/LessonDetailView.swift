import SwiftUI

struct LessonDetailView: View {
    let lesson: Lesson
    @StateObject private var progress = ProgressManager.shared
    @State private var showQuiz = false
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                lessonHeader

                // Sections
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(lesson.sections) { section in
                        SectionCard(section: section)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)

                // Bottom CTA
                bottomCTA
                    .padding(.top, 32)
                    .padding(.bottom, 40)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showQuiz) {
            QuizView(lesson: lesson)
        }
    }

    // MARK: Header
    private var lessonHeader: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: headerGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(alignment: .leading, spacing: 10) {
                Text(lesson.emoji)
                    .font(.system(size: 56))
                Text(lesson.title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Text(lesson.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                HStack(spacing: 12) {
                    Label(lesson.difficulty.rawValue, systemImage: "speedometer")
                    Label("\(lesson.estimatedMinutes) min read", systemImage: "clock")
                    if progress.isCompleted(lesson.id) {
                        Label("Completed", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .font(.caption.bold())
                .foregroundColor(.white.opacity(0.9))
            }
            .padding(24)
        }
    }

    private var headerGradient: [Color] {
        switch lesson.difficulty {
        case .beginner: return [.blue, .cyan]
        case .intermediate: return [.purple, .indigo]
        case .advanced: return [.orange, .red]
        }
    }

    // MARK: Bottom CTA
    private var bottomCTA: some View {
        VStack(spacing: 12) {
            if progress.isCompleted(lesson.id) {
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                    Text("Lesson completed!")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Button {
                    showQuiz = true
                } label: {
                    Label("Retake Quiz", systemImage: "arrow.clockwise")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemGroupedBackground))
                        .foregroundColor(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
            } else {
                Button {
                    showQuiz = true
                } label: {
                    Label("Take the Quiz", systemImage: "pencil.and.list.clipboard")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
                Text("Pass the quiz to mark this lesson complete.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Section Card
private struct SectionCard: View {
    let section: ContentSection
    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Heading with expand/collapse
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(section.heading)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                Text(section.body)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                if let code = section.codeExample {
                    CodeBlock(code: code)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Code Block
struct CodeBlock: View {
    let code: String
    @State private var copied = false

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            // Copy button
            Button {
                UIPasteboard.general.string = code
                copied = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { copied = false }
            } label: {
                Label(copied ? "Copied!" : "Copy", systemImage: copied ? "checkmark" : "doc.on.doc")
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(Capsule())
                    .foregroundColor(copied ? .green : .secondary)
            }

            // Code text
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
        }
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
    }
}

#Preview {
    NavigationStack {
        LessonDetailView(lesson: LessonData.all[0])
    }
}
