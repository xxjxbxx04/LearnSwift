import SwiftUI

struct CheatSheetView: View {
    @State private var searchText = ""

    var filteredSections: [CheatSheetSection] {
        if searchText.isEmpty {
            return CheatSheetData.sections
        }
        let query = searchText.lowercased()
        return CheatSheetData.sections.compactMap { section in
            let matchingItems = section.items.filter {
                $0.label.lowercased().contains(query) ||
                $0.syntax.lowercased().contains(query)
            }
            guard !matchingItems.isEmpty else { return nil }
            return CheatSheetSection(
                id: section.id,
                title: section.title,
                emoji: section.emoji,
                items: matchingItems
            )
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredSections.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20, pinnedViews: []) {
                            ForEach(filteredSections) { section in
                                CheatSheetSectionView(section: section)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Cheat Sheet")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search syntax…")
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No Results")
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text("No syntax matched "\(searchText)".\nTry a different search term.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
    }
}

// MARK: - Section View

private struct CheatSheetSectionView: View {
    let section: CheatSheetSection

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Section header
            HStack(spacing: 8) {
                Text(section.emoji)
                    .font(.title3)
                Text(section.title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(UnevenRoundedRectangle(
                topLeadingRadius: 16,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 16
            ))

            Divider()
                .padding(.horizontal, 16)
                .background(Color(.secondarySystemGroupedBackground))

            // Items
            VStack(spacing: 0) {
                ForEach(Array(section.items.enumerated()), id: \.element.id) { index, item in
                    CheatSheetItemView(item: item)

                    if index < section.items.count - 1 {
                        Divider()
                            .padding(.leading, 16)
                            .background(Color(.secondarySystemGroupedBackground))
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 16,
                bottomTrailingRadius: 16,
                topTrailingRadius: 0
            ))
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Item View

private struct CheatSheetItemView: View {
    let item: CheatSheetItem
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.label)
                .font(.subheadline.bold())
                .foregroundColor(.primary)

            // Syntax code block
            HStack(alignment: .top, spacing: 8) {
                Text(item.syntax)
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button {
                    UIPasteboard.general.string = item.syntax
                    withAnimation(.easeInOut(duration: 0.2)) {
                        copied = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            copied = false
                        }
                    }
                } label: {
                    Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        .font(.caption)
                        .foregroundColor(copied ? .green : .secondary)
                        .frame(width: 28, height: 28)
                        .background(Color(.systemBackground).opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
            }
            .padding(10)
            .background(Color(.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            if let note = item.note {
                Text(note)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.secondarySystemGroupedBackground))
    }
}

#Preview {
    CheatSheetView()
}
