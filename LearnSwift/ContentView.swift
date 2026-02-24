import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }
                .tag(0)

            GlossaryView()
                .tabItem {
                    Label("Glossary", systemImage: "character.book.closed.fill")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
