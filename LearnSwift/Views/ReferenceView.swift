import SwiftUI

struct ReferenceView: View {
    let cards: [ReferenceCard] = [
        ReferenceCard(
            title: "Cheat Sheet",
            subtitle: "Syntax at a glance",
            emoji: "📋",
            accentColor: .blue,
            destination: AnyView(CheatSheetView())
        ),
        ReferenceCard(
            title: "Error Guide",
            subtitle: "Decode Xcode errors",
            emoji: "🚨",
            accentColor: .red,
            destination: AnyView(ErrorDictionaryView())
        ),
        ReferenceCard(
            title: "Xcode Guide",
            subtitle: "Master the IDE",
            emoji: "🖥️",
            accentColor: .indigo,
            destination: AnyView(XcodeGuideView())
        ),
        ReferenceCard(
            title: "Mini Projects",
            subtitle: "Build real things",
            emoji: "🛠️",
            accentColor: .green,
            destination: AnyView(MiniProjectsView())
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header banner
                    headerBanner

                    // 2x2 grid
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ],
                        spacing: 16
                    ) {
                        ForEach(cards) { card in
                            NavigationLink(destination: card.destination) {
                                ReferenceCardView(card: card)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }

    private var headerBanner: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 8) {
                Text("📖")
                    .font(.system(size: 48))

                Text("Reference")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("Your Swift quick-reference library")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.vertical, 36)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Reference Card Model

struct ReferenceCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let emoji: String
    let accentColor: Color
    let destination: AnyView
}

// MARK: - Reference Card View

struct ReferenceCardView: View {
    let card: ReferenceCard

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Colored accent strip at top
            card.accentColor
                .frame(height: 5)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 16,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 16
                    )
                )

            VStack(alignment: .leading, spacing: 10) {
                Text(card.emoji)
                    .font(.system(size: 36))

                VStack(alignment: .leading, spacing: 4) {
                    Text(card.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)

                    Text(card.subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }

                HStack {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(14)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(card.accentColor.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ReferenceView()
}
