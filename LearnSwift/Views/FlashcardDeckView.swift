import SwiftUI

struct FlashcardDeckView: View {
    let category: String?

    @State private var cards: [Flashcard] = []
    @State private var currentIndex: Int = 0
    @State private var isFlipped: Bool = false
    @State private var isComplete: Bool = false

    private var navigationTitle: String {
        category ?? "All Flashcards"
    }

    // MARK: Body

    var body: some View {
        NavigationStack {
            Group {
                if isComplete {
                    completionView
                } else if cards.isEmpty {
                    emptyView
                } else {
                    deckView
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !cards.isEmpty && !isComplete {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            shuffleDeck()
                        } label: {
                            Label("Shuffle", systemImage: "shuffle")
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            loadCards()
        }
    }

    // MARK: Deck View

    private var deckView: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Progress bar
                progressBar

                // Flippable card
                flashcard
                    .padding(.horizontal)

                // Navigation controls
                navigationControls

                // Reset button
                Button {
                    resetDeck()
                } label: {
                    Label("Reset to Card 1", systemImage: "arrow.counterclockwise")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
                .padding(.top, 4)
            }
            .padding(.vertical, 16)
            .padding(.bottom, 30)
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: Progress Bar

    private var progressBar: some View {
        VStack(spacing: 6) {
            HStack {
                Text("Card \(currentIndex + 1) of \(cards.count)")
                    .font(.subheadline.bold())
                    .foregroundColor(.primary)
                Spacer()
                Text(navigationTitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            ProgressView(value: Double(currentIndex + 1), total: Double(cards.count))
                .tint(.blue)
                .padding(.horizontal)
        }
    }

    // MARK: Flashcard

    private var flashcard: some View {
        ZStack {
            // Front face
            CardFace(
                label: "QUESTION",
                text: cards[currentIndex].front,
                gradient: LinearGradient(
                    colors: [.blue, Color(red: 0.2, green: 0.4, blue: 0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .opacity(isFlipped ? 0 : 1)
            .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))

            // Back face
            CardFace(
                label: "ANSWER",
                text: cards[currentIndex].back,
                gradient: LinearGradient(
                    colors: [.indigo, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .opacity(isFlipped ? 1 : 0)
            .rotation3DEffect(.degrees(isFlipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
        }
        .frame(minHeight: 260)
        .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                isFlipped.toggle()
            }
        }
    }

    // MARK: Navigation Controls

    private var navigationControls: some View {
        HStack(spacing: 20) {
            // Previous
            Button {
                goToPrevious()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Prev")
                }
                .font(.subheadline.bold())
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color(.secondarySystemGroupedBackground))
                .foregroundColor(currentIndex == 0 ? .secondary : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(currentIndex == 0)
            .buttonStyle(.plain)

            Spacer()

            Text("\(currentIndex + 1) of \(cards.count)")
                .font(.subheadline.monospacedDigit())
                .foregroundColor(.secondary)

            Spacer()

            // Next
            Button {
                goToNext()
            } label: {
                HStack(spacing: 6) {
                    Text(currentIndex + 1 == cards.count ? "Done" : "Next")
                    Image(systemName: "chevron.right")
                }
                .font(.subheadline.bold())
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    currentIndex + 1 == cards.count
                        ? Color.green.opacity(0.15)
                        : Color(.secondarySystemGroupedBackground)
                )
                .foregroundColor(currentIndex + 1 == cards.count ? .green : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }

    // MARK: Completion View

    private var completionView: some View {
        ScrollView {
            VStack(spacing: 28) {
                Spacer(minLength: 40)

                Text("🎉")
                    .font(.system(size: 72))

                Text("Deck Complete!")
                    .font(.largeTitle.bold())

                Text("You've reviewed all \(cards.count) cards in \(navigationTitle).")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(spacing: 12) {
                    Button {
                        resetDeck()
                        withAnimation { isComplete = false }
                    } label: {
                        Label("Start Over", systemImage: "arrow.counterclockwise")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)

                    Button {
                        shuffleDeck()
                        withAnimation { isComplete = false }
                    } label: {
                        Label("Shuffle & Restart", systemImage: "shuffle")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.secondarySystemGroupedBackground))
                            .foregroundColor(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: Empty View

    private var emptyView: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("📭")
                .font(.system(size: 52))
            Text("No cards found")
                .font(.headline)
            Text("There are no flashcards in this category yet.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: Helpers

    private func loadCards() {
        if let cat = category {
            cards = FlashcardData.all.filter { $0.category == cat }
        } else {
            cards = FlashcardData.all
        }
        currentIndex = 0
        isFlipped = false
        isComplete = false
    }

    private func goToNext() {
        guard currentIndex < cards.count else { return }
        withAnimation(.easeInOut(duration: 0.2)) {
            isFlipped = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if currentIndex + 1 >= cards.count {
                withAnimation { isComplete = true }
            } else {
                withAnimation { currentIndex += 1 }
            }
        }
    }

    private func goToPrevious() {
        guard currentIndex > 0 else { return }
        withAnimation(.easeInOut(duration: 0.2)) {
            isFlipped = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation { currentIndex -= 1 }
        }
    }

    private func shuffleDeck() {
        cards.shuffle()
        currentIndex = 0
        isFlipped = false
        isComplete = false
    }

    private func resetDeck() {
        currentIndex = 0
        isFlipped = false
        isComplete = false
    }
}

// MARK: - Card Face

private struct CardFace: View {
    let label: String
    let text: String
    let gradient: LinearGradient

    var body: some View {
        ZStack {
            gradient
            VStack(spacing: 16) {
                Text(label)
                    .font(.caption.bold())
                    .tracking(2)
                    .foregroundColor(.white.opacity(0.75))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.15))
                    .clipShape(Capsule())

                Text(text)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 8)

                Text("Tap to flip")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.55))
            }
            .padding(24)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    FlashcardDeckView(category: nil)
}
