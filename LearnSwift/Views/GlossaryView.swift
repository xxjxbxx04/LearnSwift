import SwiftUI

struct GlossaryView: View {
    @State private var searchText = ""
    @State private var selectedCategory: GlossaryTerm.Category? = nil

    private var filteredTerms: [GlossaryTerm] {
        GlossaryTerm.all
            .filter { term in
                let matchesSearch = searchText.isEmpty ||
                    term.term.localizedCaseInsensitiveContains(searchText) ||
                    term.oneLiner.localizedCaseInsensitiveContains(searchText) ||
                    term.analogy.localizedCaseInsensitiveContains(searchText)
                let matchesCategory = selectedCategory == nil || term.category == selectedCategory
                return matchesSearch && matchesCategory
            }
            .sorted { $0.term < $1.term }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category filter chips
                categoryFilter

                // Term list
                if filteredTerms.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(filteredTerms) { term in
                                TermCard(term: term)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Glossary")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search terms…")
        }
    }

    // MARK: Category Filter
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // "All" chip
                CategoryChip(
                    label: "All",
                    emoji: "⭐",
                    isSelected: selectedCategory == nil
                ) { selectedCategory = nil }

                ForEach(GlossaryTerm.Category.allCases, id: \.self) { cat in
                    CategoryChip(
                        label: cat.rawValue,
                        emoji: categoryEmoji(cat),
                        isSelected: selectedCategory == cat
                    ) {
                        selectedCategory = selectedCategory == cat ? nil : cat
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .background(Color(.secondarySystemGroupedBackground))
    }

    // MARK: Empty State
    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("🔍")
                .font(.system(size: 52))
            Text("No results for \"\(searchText)\"")
                .font(.headline)
                .foregroundColor(.primary)
            Text("Try a different word or clear the filter.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }

    private func categoryEmoji(_ cat: GlossaryTerm.Category) -> String {
        switch cat {
        case .basics:      return "📗"
        case .controlFlow: return "🚦"
        case .loops:       return "🔄"
        case .functions:   return "⚙️"
        case .collections: return "📚"
        case .oop:         return "🏛️"
        case .advanced:    return "🚀"
        case .swiftUI:     return "📱"
        }
    }
}

// MARK: - Category Chip
private struct CategoryChip: View {
    let label: String
    let emoji: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(emoji).font(.caption)
                Text(label).font(.caption.bold())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.blue : Color(.tertiarySystemBackground))
            .foregroundColor(isSelected ? .white : .primary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.blue : Color(.separator), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Term Card
private struct TermCard: View {
    let term: GlossaryTerm
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header — always visible
            Button {
                withAnimation(.easeInOut(duration: 0.22)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 12) {
                    // Emoji badge
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(categoryColor(term.category).opacity(0.15))
                            .frame(width: 44, height: 44)
                        Text(term.emoji)
                            .font(.title3)
                    }

                    // Term + one-liner
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(spacing: 6) {
                            Text(term.term)
                                .font(.headline)
                                .foregroundColor(.primary)
                            categoryBadge
                        }
                        Text(term.oneLiner)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(isExpanded ? nil : 2)
                    }

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .buttonStyle(.plain)

            // Expanded content
            if isExpanded {
                Divider().padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    // Real-world analogy
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Real-World Analogy", systemImage: "lightbulb.fill")
                            .font(.subheadline.bold())
                            .foregroundColor(.orange)

                        Text(term.analogy)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.06))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Code example
                    if let code = term.codeExample {
                        VStack(alignment: .leading, spacing: 6) {
                            Label("In Code", systemImage: "chevron.left.forwardslash.chevron.right")
                                .font(.subheadline.bold())
                                .foregroundColor(.blue)

                            GlossaryCodeBlock(code: code)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
                .padding(.top, 10)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var categoryBadge: some View {
        Text(term.category.rawValue)
            .font(.caption2.bold())
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(categoryColor(term.category).opacity(0.12))
            .foregroundColor(categoryColor(term.category))
            .clipShape(Capsule())
    }

    private func categoryColor(_ cat: GlossaryTerm.Category) -> Color {
        switch cat {
        case .basics:      return .green
        case .controlFlow: return .orange
        case .loops:       return .purple
        case .functions:   return .blue
        case .collections: return .teal
        case .oop:         return .indigo
        case .advanced:    return .red
        case .swiftUI:     return .pink
        }
    }
}

// MARK: - Glossary Code Block
private struct GlossaryCodeBlock: View {
    let code: String
    @State private var copied = false

    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
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

            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
            }
        }
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
    }
}

#Preview {
    GlossaryView()
}
