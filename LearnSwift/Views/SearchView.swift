import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool

    private var lessonResults: [Lesson] {
        guard !searchText.isEmpty else { return [] }
        let q = searchText.lowercased()
        return LessonData.all.filter {
            $0.title.lowercased().contains(q) ||
            $0.subtitle.lowercased().contains(q) ||
            $0.sections.contains(where: { $0.heading.lowercased().contains(q) || $0.body.lowercased().contains(q) })
        }
    }

    private var glossaryResults: [GlossaryTerm] {
        guard !searchText.isEmpty else { return [] }
        let q = searchText.lowercased()
        return GlossaryTerm.all.filter {
            $0.term.lowercased().contains(q) ||
            $0.oneLiner.lowercased().contains(q) ||
            $0.analogy.lowercased().contains(q)
        }
    }

    private var cheatResults: [(section: String, item: CheatSheetItem)] {
        guard !searchText.isEmpty else { return [] }
        let q = searchText.lowercased()
        return CheatSheetData.sections.flatMap { section in
            section.items
                .filter { $0.label.lowercased().contains(q) || $0.syntax.lowercased().contains(q) }
                .map { (section: section.title, item: $0) }
        }
    }

    private var hasResults: Bool {
        !lessonResults.isEmpty || !glossaryResults.isEmpty || !cheatResults.isEmpty
    }

    var body: some View {
        NavigationStack {
            Group {
                if searchText.isEmpty {
                    emptyPrompt
                } else if !hasResults {
                    noResults
                } else {
                    resultsList
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search lessons, terms, syntax…")
        }
    }

    // MARK: Empty prompt
    private var emptyPrompt: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 56))
                .foregroundColor(.secondary.opacity(0.5))
            Text("Search Everything")
                .font(.title2.bold())
                .foregroundColor(.primary)
            Text("Search across all 32 lessons, glossary terms, and the Swift cheat sheet at once.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Spacer()
        }
    }

    // MARK: No results
    private var noResults: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("🔍")
                .font(.system(size: 52))
            Text("No results for \"\(searchText)\"")
                .font(.headline)
            Text("Try a different keyword.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Spacer()
        }
    }

    // MARK: Results list
    private var resultsList: some View {
        List {
            if !lessonResults.isEmpty {
                Section("Lessons (\(lessonResults.count))") {
                    ForEach(lessonResults) { lesson in
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
                            }
                            .padding(.vertical, 2)
                        }
                    }
                }
            }

            if !glossaryResults.isEmpty {
                Section("Glossary (\(glossaryResults.count))") {
                    ForEach(glossaryResults) { term in
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
                        .padding(.vertical, 2)
                    }
                }
            }

            if !cheatResults.isEmpty {
                Section("Cheat Sheet (\(cheatResults.count))") {
                    ForEach(Array(cheatResults.enumerated()), id: \.offset) { _, result in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text(result.section)
                                    .font(.caption.bold())
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Capsule())
                                Text(result.item.label)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.primary)
                            }
                            Text(result.item.syntax)
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    SearchView()
}
