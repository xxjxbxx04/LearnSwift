import SwiftUI

@main
struct LearnSwiftApp: App {
    init() {
        StreakManager.shared.checkIn()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
