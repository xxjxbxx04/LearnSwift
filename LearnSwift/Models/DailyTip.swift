import Foundation

struct DailyTip {
    let text: String
    let category: String

    static let all: [DailyTip] = [
        // Variables & Constants
        DailyTip(text: "Use `let` by default. Only switch to `var` when you actually need to change the value later.", category: "Variables"),
        DailyTip(text: "Swift infers types automatically. `let name = \"Alice\"` is cleaner than `let name: String = \"Alice\"` when the type is obvious.", category: "Variables"),
        DailyTip(text: "Naming matters. `let userAge = 25` is far clearer than `let x = 25`. Your future self will thank you.", category: "Variables"),
        DailyTip(text: "Constants (`let`) are not just a style choice — they help Swift optimize your code and prevent accidental mutations.", category: "Variables"),

        // Functions
        DailyTip(text: "Use argument labels to make function calls read like English: `func greet(person name: String)` → `greet(person: \"Alice\")`.", category: "Functions"),
        DailyTip(text: "Use `_` as an argument label to skip it at the call site: `func double(_ n: Int) -> Int` → `double(5)`.", category: "Functions"),
        DailyTip(text: "Keep functions small and focused. If a function is doing two things, it should probably be two functions.", category: "Functions"),

        // Optionals
        DailyTip(text: "Use `guard let` at the top of functions to exit early if required values are missing. It keeps the happy path un-indented.", category: "Optionals"),
        DailyTip(text: "Avoid force-unwrapping (`!`) in production code. If the value is ever nil at runtime, your app will crash immediately.", category: "Optionals"),
        DailyTip(text: "The nil-coalescing operator `??` is great for providing defaults: `let name = user.name ?? \"Guest\"`.", category: "Optionals"),
        DailyTip(text: "Optional chaining `?.` lets you safely call methods or access properties on optionals without crashing: `user?.address?.city`.", category: "Optionals"),

        // Strings
        DailyTip(text: "String interpolation `\\(value)` is usually cleaner than concatenating with `+`. Use `\"Hello, \\(name)!\"` instead of `\"Hello, \" + name + \"!\"`.", category: "Strings"),
        DailyTip(text: "Use multi-line strings with triple quotes `\"\"\"` when you need a string that spans multiple lines.", category: "Strings"),
        DailyTip(text: "`String` in Swift is a value type — assigning it to a new variable copies it. Modifying the copy won't change the original.", category: "Strings"),

        // Control Flow
        DailyTip(text: "Switch statements in Swift are exhaustive — you must handle every case. Use `default:` to catch anything you haven't explicitly handled.", category: "Control Flow"),
        DailyTip(text: "The ternary operator `condition ? a : b` is great for short expressions, but avoid nesting them — it gets unreadable fast.", category: "Control Flow"),
        DailyTip(text: "`if let` and `guard let` do the same unwrapping job, but `guard let` keeps your code flatter by exiting early.", category: "Control Flow"),

        // Loops
        DailyTip(text: "Use `for index in 0..<array.count` when you need the index, but `for item in array` is cleaner when you just need the value.", category: "Loops"),
        DailyTip(text: "Use `enumerated()` to get both index and value in a loop: `for (index, item) in items.enumerated()`.", category: "Loops"),
        DailyTip(text: "`break` exits a loop entirely. `continue` just skips the current iteration and moves to the next one.", category: "Loops"),

        // Collections
        DailyTip(text: "Use `filter`, `map`, and `reduce` for clean collection transformations instead of manual for-loops.", category: "Collections"),
        DailyTip(text: "Swift arrays are value types. Passing an array to a function copies it — changes inside the function don't affect the original.", category: "Collections"),
        DailyTip(text: "Use `Set` instead of `Array` when order doesn't matter and you need fast membership checks with `contains`.", category: "Collections"),
        DailyTip(text: "Dictionary lookup returns an optional: `dict[\"key\"]` is `String?`, not `String`. Always unwrap it safely.", category: "Collections"),

        // SwiftUI
        DailyTip(text: "In SwiftUI, `@State` is for local view state. If multiple views need the same data, lift it up or use `@StateObject`.", category: "SwiftUI"),
        DailyTip(text: "`@Binding` lets a child view read and write a parent's `@State`. Pass it with `$`: `ChildView(isOn: $isEnabled)`.", category: "SwiftUI"),
        DailyTip(text: "SwiftUI views are re-computed whenever their state changes. Keep your view body fast — move heavy logic out of the body.", category: "SwiftUI"),
        DailyTip(text: "Use `.padding()` generously in SwiftUI. It makes UIs feel polished and content easier to read on all device sizes.", category: "SwiftUI"),
        DailyTip(text: "Use `Spacer()` inside stacks to push views apart. It's the SwiftUI equivalent of a flexible gap.", category: "SwiftUI"),

        // Xcode
        DailyTip(text: "Cmd+R in Xcode runs your app in the Simulator. Cmd+B just builds without running — useful to check for errors.", category: "Xcode"),
        DailyTip(text: "Option+Click any symbol in Xcode to see its inline documentation without leaving your file.", category: "Xcode"),
        DailyTip(text: "Cmd+Shift+O (Open Quickly) is the fastest way to jump to any file or symbol in your project.", category: "Xcode"),
        DailyTip(text: "Cmd+/ comments or uncomments the selected line(s). Use it constantly — commenting out code to test is faster than deleting it.", category: "Xcode"),
        DailyTip(text: "Click the red dot in Xcode's error sidebar to see Fix-it suggestions. Xcode can often auto-correct simple mistakes for you.", category: "Xcode"),
        DailyTip(text: "Add a breakpoint by clicking the line-number gutter. When the app hits that line, it pauses so you can inspect every variable.", category: "Xcode"),
    ]

    static var today: DailyTip {
        let cal        = Calendar.current
        let dayOfYear  = cal.ordinality(of: .day, in: .year, for: Date()) ?? 1
        return all[dayOfYear % all.count]
    }
}
