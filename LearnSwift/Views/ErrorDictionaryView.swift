import SwiftUI

struct ErrorDictionaryView: View {
    @State private var searchText = ""
    @State private var selectedEntry: ErrorEntry? = nil

    var filteredErrors: [ErrorEntry] {
        if searchText.isEmpty {
            return ErrorData.all
        }
        let query = searchText.lowercased()
        return ErrorData.all.filter {
            $0.errorMessage.lowercased().contains(query) ||
            $0.plainEnglish.lowercased().contains(query) ||
            $0.howToFix.lowercased().contains(query)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredErrors.isEmpty {
                    emptyState
                } else {
                    List(filteredErrors) { entry in
                        ErrorRowView(entry: entry)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedEntry = entry
                            }
                            .listRowBackground(Color(.secondarySystemGroupedBackground))
                            .listRowSeparatorTint(Color(.separator).opacity(0.5))
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationTitle("Error Guide")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search errors…")
            .sheet(item: $selectedEntry) { entry in
                ErrorDetailView(entry: entry)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No Errors Found")
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text("No errors matched \"\(searchText)\".\nTry searching by message or keyword.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Error Row View

private struct ErrorRowView: View {
    let entry: ErrorEntry

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(entry.emoji)
                .font(.title2)
                .frame(width: 36, height: 36)
                .background(Color(.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.errorMessage)
                    .font(.system(.subheadline, design: .monospaced))
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(entry.plainEnglish)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Error Detail View

private struct ErrorDetailView: View {
    let entry: ErrorEntry
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Error message header
                    errorMessageHeader

                    VStack(spacing: 16) {
                        // Plain English
                        InfoSection(
                            icon: "text.bubble.fill",
                            iconColor: .orange,
                            title: "In Plain English",
                            content: entry.plainEnglish
                        )

                        // Why It Happens
                        InfoSection(
                            icon: "questionmark.circle.fill",
                            iconColor: .yellow,
                            title: "Why It Happens",
                            content: entry.whyItHappens
                        )

                        // How to Fix
                        InfoSection(
                            icon: "wrench.and.screwdriver.fill",
                            iconColor: .green,
                            title: "How to Fix It",
                            content: entry.howToFix
                        )

                        // Bad code block
                        if let badCode = entry.badCode {
                            CodeBlockCard(
                                label: "❌ This causes it",
                                code: badCode,
                                tintColor: .red
                            )
                        }

                        // Good code block
                        if let goodCode = entry.goodCode {
                            CodeBlockCard(
                                label: "✅ Fix it like this",
                                code: goodCode,
                                tintColor: .green
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(entry.emoji)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .fontWeight(.semibold)
                }
            }
        }
    }

    private var errorMessageHeader: some View {
        VStack(spacing: 12) {
            Text(entry.emoji)
                .font(.system(size: 48))

            Text(entry.errorMessage)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color.red.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.red.opacity(0.2), lineWidth: 1)
                )
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

// MARK: - Info Section

private struct InfoSection: View {
    let icon: String
    let iconColor: Color
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.subheadline)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            Text(content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Code Block Card

private struct CodeBlockCard: View {
    let label: String
    let code: String
    let tintColor: Color
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.headline)
                .foregroundColor(.primary)

            HStack(alignment: .top, spacing: 8) {
                Text(code)
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

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
                    Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        .font(.caption)
                        .foregroundColor(copied ? .green : .secondary)
                        .frame(width: 28, height: 28)
                        .background(Color(.systemBackground).opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
            }
            .padding(12)
            .background(Color(.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(tintColor.opacity(0.25), lineWidth: 1)
        )
    }
}

#Preview {
    ErrorDictionaryView()
}
