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

            PracticeView()
                .tabItem {
                    Label("Practice", systemImage: "gamecontroller.fill")
                }
                .tag(1)

            ReferenceView()
                .tabItem {
                    Label("Reference", systemImage: "doc.text.fill")
                }
                .tag(2)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(3)

            ProfileView()
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
                .tag(4)
        }
    }
}

#Preview {
    ContentView()
}
