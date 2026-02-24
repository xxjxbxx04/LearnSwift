import Foundation

struct XcodeGuideStep: Identifiable {
    let id = UUID()
    let instruction: String
    let detail: String
}

struct XcodeGuideSection: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let overview: String
    let steps: [XcodeGuideStep]
    let proTip: String?
}

struct XcodeGuideData {
    static let sections: [XcodeGuideSection] = [

        XcodeGuideSection(
            emoji: "🗺️",
            title: "The Xcode Interface",
            overview: "Learn your way around the five key areas of Xcode: the toolbar, navigator, editor, canvas, and inspector.",
            steps: [
                XcodeGuideStep(instruction: "Open Xcode and your project.", detail: "Double-click the .xcodeproj file on your Desktop to open the project in Xcode."),
                XcodeGuideStep(instruction: "Find the Project Navigator on the left.", detail: "The left sidebar lists all your files. Click any .swift file to open it in the editor. Press Cmd+1 to show/hide it."),
                XcodeGuideStep(instruction: "Look at the Editor in the center.", detail: "This is where you write your code. When a SwiftUI file is open, you'll see the canvas on the right side showing a live preview."),
                XcodeGuideStep(instruction: "Find the Inspector on the right.", detail: "The right sidebar shows properties for the selected file or view. Press Cmd+Option+0 to toggle it."),
                XcodeGuideStep(instruction: "Find the Debug Area at the bottom.", detail: "When your app runs, debug output and print() messages appear here. Press Cmd+Shift+Y to toggle it."),
            ],
            proTip: "Use the View menu → Show Library (Cmd+Shift+L) to browse SwiftUI components you can drag into your code."
        ),

        XcodeGuideSection(
            emoji: "🆕",
            title: "Creating a New Project",
            overview: "How to create a brand-new iOS app project from scratch in Xcode.",
            steps: [
                XcodeGuideStep(instruction: "Open Xcode and choose 'Create New Project'.", detail: "On the Welcome screen, click 'Create New Project…'. If Xcode is already open, go to File → New → Project (Cmd+Shift+N)."),
                XcodeGuideStep(instruction: "Select iOS → App and click Next.", detail: "Make sure the 'iOS' tab is selected at the top, then choose the 'App' template."),
                XcodeGuideStep(instruction: "Fill in your project details.", detail: "Product Name: your app's name. Team: your Apple ID. Bundle Identifier: reverse-domain format like com.yourname.appname. Interface: SwiftUI. Language: Swift."),
                XcodeGuideStep(instruction: "Choose where to save the project.", detail: "Pick a folder (Desktop is fine). Uncheck 'Create Git repository' if you'll set it up yourself later. Click Create."),
                XcodeGuideStep(instruction: "Explore the generated files.", detail: "Xcode creates ContentView.swift (your first screen) and Assets.xcassets (for images and icons). ContentView.swift already shows 'Hello, world!'."),
            ],
            proTip: "Name your Bundle Identifier carefully — once submitted to the App Store, you can't change it."
        ),

        XcodeGuideSection(
            emoji: "▶️",
            title: "Building & Running Your App",
            overview: "How to build your code and run it on the Simulator or a real iPhone.",
            steps: [
                XcodeGuideStep(instruction: "Select a Simulator from the device menu.", detail: "At the top of Xcode, click the device selector (it shows something like 'iPhone 15'). Choose any iPhone model from the list."),
                XcodeGuideStep(instruction: "Press Cmd+R to Run.", detail: "Xcode builds your code (compiles it), then launches the Simulator and installs your app. Watch the progress bar at the top."),
                XcodeGuideStep(instruction: "Watch for build errors.", detail: "If there are errors, the build stops and Xcode shows red error badges. Click an error to jump to the line of code that caused it."),
                XcodeGuideStep(instruction: "Use Cmd+B to Build without running.", detail: "This checks your code for errors without launching the Simulator — faster for just checking your work."),
                XcodeGuideStep(instruction: "Run on a real device.", detail: "Connect your iPhone with a cable. Select it from the device menu. You need a free Apple Developer account signed in under Xcode → Settings → Accounts."),
            ],
            proTip: "Hold the Run button to get options like Profile (for performance) and Test. Cmd+. stops the running app."
        ),

        XcodeGuideSection(
            emoji: "📱",
            title: "Using the Simulator",
            overview: "The Simulator lets you test your app on virtual iPhones and iPads without a physical device.",
            steps: [
                XcodeGuideStep(instruction: "Launch the Simulator via Cmd+R.", detail: "The Simulator opens as a separate window that looks and behaves like a real iPhone. Click buttons, scroll, and type just like on a real device."),
                XcodeGuideStep(instruction: "Rotate the device.", detail: "Press Cmd+Left or Cmd+Right arrow to rotate the Simulator between portrait and landscape."),
                XcodeGuideStep(instruction: "Simulate a Home button press.", detail: "Press Cmd+Shift+H to go to the Home screen. Press it twice to open the App Switcher."),
                XcodeGuideStep(instruction: "Take a screenshot.", detail: "Press Cmd+S while the Simulator is active to save a screenshot to your Desktop. Useful for App Store submissions."),
                XcodeGuideStep(instruction: "Change the Simulator device.", detail: "In Xcode, click the device menu and pick a different iPhone or iPad model. Run again (Cmd+R) and the new Simulator opens."),
            ],
            proTip: "You can run multiple Simulators at once — just select different devices and run. Great for testing different screen sizes."
        ),

        XcodeGuideSection(
            emoji: "🖼️",
            title: "SwiftUI Canvas (Preview)",
            overview: "The canvas shows a live preview of your SwiftUI views without running the full app.",
            steps: [
                XcodeGuideStep(instruction: "Open a SwiftUI file.", detail: "Click any View file (like ContentView.swift). If the canvas doesn't appear, press Cmd+Option+Return or go to Editor → Canvas."),
                XcodeGuideStep(instruction: "Wait for the preview to load.", detail: "Xcode compiles your code in the background. You'll see a spinner, then your view appears. Click 'Resume' if it pauses."),
                XcodeGuideStep(instruction: "Make a change and see it update instantly.", detail: "Edit your view code and the canvas refreshes automatically — no need to rebuild the whole app."),
                XcodeGuideStep(instruction: "Use the Preview pinning button.", detail: "Click the pin icon (📌) at the bottom of the canvas to keep a preview visible while you edit other files."),
                XcodeGuideStep(instruction: "Preview in different modes.", detail: "Click the device name below the canvas to switch between iPhone models. Use the color scheme button to preview Dark Mode."),
            ],
            proTip: "Add multiple #Preview blocks at the bottom of your file to preview different states simultaneously."
        ),

        XcodeGuideSection(
            emoji: "🐛",
            title: "Debugging Basics",
            overview: "When something goes wrong, these tools help you understand what's happening inside your app.",
            steps: [
                XcodeGuideStep(instruction: "Use print() to inspect values.", detail: "Add print(\"Value is \\(myVariable)\") anywhere in your code. The output appears in Xcode's Debug Area (bottom panel) when the app runs."),
                XcodeGuideStep(instruction: "Set a breakpoint.", detail: "Click the line number gutter to add a blue breakpoint arrow. When your app hits that line, it pauses so you can inspect values."),
                XcodeGuideStep(instruction: "Inspect variables at a breakpoint.", detail: "When paused at a breakpoint, hover over any variable in the code to see its value. Or look in the Variables View in the Debug Area."),
                XcodeGuideStep(instruction: "Step through code.", detail: "When paused, use the debug toolbar: Step Over (F6) runs one line. Step Into (F7) enters a function. Continue (F5) resumes normal execution."),
                XcodeGuideStep(instruction: "Read crash logs.", detail: "If your app crashes, Xcode shows the crash details in the Debug Area. The red thread usually shows exactly where the crash happened."),
            ],
            proTip: "Right-click a breakpoint to add a condition — it only pauses when the condition is true. Great for debugging loops."
        ),

        XcodeGuideSection(
            emoji: "🔧",
            title: "Finding & Fixing Errors",
            overview: "Xcode catches many mistakes before you even run your app. Here's how to read and fix them.",
            steps: [
                XcodeGuideStep(instruction: "Look at the red error badge.", detail: "Red circles with numbers in the top bar show errors. Yellow triangles show warnings. Click them to see the full list."),
                XcodeGuideStep(instruction: "Click an error to jump to it.", detail: "In the Issue Navigator (Cmd+4), click any error to jump to the exact line. The error message appears inline in the code."),
                XcodeGuideStep(instruction: "Try the Fix-it suggestion.", detail: "Many errors have a Fix-it button (lightning bolt icon). Click it to let Xcode apply an automatic fix. Always review what it changes."),
                XcodeGuideStep(instruction: "Option+click for documentation.", detail: "Hold Option and click any symbol (type name, function, property) to see a popup with its documentation and type signature."),
                XcodeGuideStep(instruction: "Use autocomplete.", detail: "Start typing and Xcode suggests completions. Press Tab to accept. Press Esc to see all options. This prevents typos in type and method names."),
            ],
            proTip: "If Xcode shows errors that seem wrong, try Product → Clean Build Folder (Cmd+Shift+K) then rebuild. This clears cached state."
        ),

        XcodeGuideSection(
            emoji: "⌨️",
            title: "Essential Keyboard Shortcuts",
            overview: "These shortcuts will make you dramatically faster in Xcode.",
            steps: [
                XcodeGuideStep(instruction: "Cmd+R — Run your app.", detail: "Builds and launches your app in the Simulator. The most-used shortcut in Xcode."),
                XcodeGuideStep(instruction: "Cmd+B — Build (no run).", detail: "Compiles your code and shows errors without launching the Simulator. Use this to quickly check for mistakes."),
                XcodeGuideStep(instruction: "Cmd+Shift+O — Open Quickly.", detail: "Type any file name, type name, or symbol to jump to it instantly. The fastest way to navigate large projects."),
                XcodeGuideStep(instruction: "Cmd+/ — Toggle comments.", detail: "Instantly comment or uncomment the selected line(s) of code. Essential for testing without deleting."),
                XcodeGuideStep(instruction: "Cmd+Z — Undo. Cmd+Shift+K — Clean Build.", detail: "Undo mistakes with Cmd+Z (works in code just like any app). Clean Build removes cached files to fix phantom errors."),
            ],
            proTip: "Cmd+Shift+L opens the SwiftUI Library — a visual browser of every SwiftUI view and modifier you can drag into your code."
        ),
    ]
}
