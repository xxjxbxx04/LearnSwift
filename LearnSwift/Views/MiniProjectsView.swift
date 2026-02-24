import SwiftUI

struct MiniProjectsView: View {
    var body: some View {
        NavigationStack {
            Group {
                if MiniProjectData.all.isEmpty {
                    emptyState
                } else {
                    List(MiniProjectData.all) { project in
                        NavigationLink(destination: MiniProjectDetailView(project: project)) {
                            MiniProjectRow(project: project)
                        }
                        .listRowBackground(Color(.secondarySystemGroupedBackground))
                        .listRowSeparatorTint(Color(.separator).opacity(0.5))
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationTitle("Mini Projects")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "hammer")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No Projects Yet")
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text("Mini projects will appear here.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Difficulty Helpers

private extension String {
    var difficultyColor: Color {
        switch self.lowercased() {
        case "beginner": return .green
        case "intermediate": return .orange
        default: return .blue
        }
    }

    var headerGradient: [Color] {
        switch self.lowercased() {
        case "beginner": return [.green, .teal]
        case "intermediate": return [.orange, .red]
        default: return [.blue, .indigo]
        }
    }
}

// MARK: - Project Row

private struct MiniProjectRow: View {
    let project: MiniProject

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(project.emoji)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color(.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 5) {
                Text(project.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack(spacing: 8) {
                    // Difficulty badge
                    Text(project.difficulty)
                        .font(.caption.bold())
                        .foregroundColor(project.difficulty.difficultyColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(project.difficulty.difficultyColor.opacity(0.12))
                        .clipShape(Capsule())

                    // Time estimate
                    Label("~\(project.estimatedMinutes) min", systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Project Detail View

struct MiniProjectDetailView: View {
    let project: MiniProject
    @State private var expandedStepIds: Set<UUID> = []

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Gradient header
                projectHeader

                // What You'll Learn
                whatYoullLearnSection

                // Steps
                stepsSection
            }
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(project.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Header

    private var projectHeader: some View {
        ZStack {
            LinearGradient(
                colors: project.difficulty.headerGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 12) {
                Text(project.emoji)
                    .font(.system(size: 60))

                Text(project.title)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text(project.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)

                HStack(spacing: 16) {
                    Label(project.difficulty, systemImage: "chart.bar.fill")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.2))
                        .clipShape(Capsule())

                    Label("~\(project.estimatedMinutes) min", systemImage: "clock.fill")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, 36)
            .padding(.horizontal, 20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    // MARK: What You'll Learn

    private var whatYoullLearnSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What You'll Learn")
                .font(.title3.bold())
                .foregroundColor(.primary)
                .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(project.whatYoullLearn, id: \.self) { item in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(project.difficulty.difficultyColor)
                            .font(.subheadline)
                            .padding(.top, 1)

                        Text(item)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
        }
    }

    // MARK: Steps

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Steps")
                .font(.title3.bold())
                .foregroundColor(.primary)
                .padding(.horizontal, 16)

            if project.steps.isEmpty {
                Text("No steps available.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)
            } else {
                ForEach(project.steps) { step in
                    ProjectStepCard(
                        step: step,
                        accentColor: project.difficulty.difficultyColor,
                        isExpanded: expandedStepIds.contains(step.id)
                    ) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            if expandedStepIds.contains(step.id) {
                                expandedStepIds.remove(step.id)
                            } else {
                                expandedStepIds.insert(step.id)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Project Step Card

private struct ProjectStepCard: View {
    let step: ProjectStep
    let accentColor: Color
    let isExpanded: Bool
    let onTap: () -> Void
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header row — always visible, tap to expand/collapse
            Button(action: onTap) {
                HStack(alignment: .center, spacing: 12) {
                    // Step number badge
                    ZStack {
                        Circle()
                            .fill(accentColor)
                            .frame(width: 32, height: 32)

                        Text("\(step.number)")
                            .font(.system(.subheadline, design: .rounded).bold())
                            .foregroundColor(.white)
                    }

                    Text(step.title)
                        .font(.subheadline.bold())
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(14)
            }
            .buttonStyle(.plain)

            // Expanded content
            if isExpanded {
                Divider()
                    .padding(.horizontal, 14)

                VStack(alignment: .leading, spacing: 12) {
                    // Explanation
                    Text(step.explanation)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    // Code block
                    if let code = step.code {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Code")
                                    .font(.caption.bold())
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                    .tracking(0.5)

                                Spacer()

                                Button {
                                    UIPasteboard.general.string = code
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        copied = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            copied = false
                                        }
                                    }
                                } label: {
                                    HStack(spacing: 4) {
                                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                                        Text(copied ? "Copied" : "Copy")
                                    }
                                    .font(.caption.bold())
                                    .foregroundColor(copied ? .green : accentColor)
                                }
                                .buttonStyle(.plain)
                            }

                            Text(code)
                                .font(.system(.footnote, design: .monospaced))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                                .background(Color(.tertiarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }

                    // Note
                    if let note = step.note {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "info.circle")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, 2)

                            Text(note)
                                .font(.caption)
                                .italic()
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(isExpanded ? accentColor.opacity(0.3) : Color.clear, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .animation(.easeInOut(duration: 0.2), value: isExpanded)
    }
}

#Preview {
    MiniProjectsView()
}
