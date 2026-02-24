import Foundation

struct DailyChallenge: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let difficulty: String  // "Beginner", "Intermediate", "Advanced"
}

struct DailyChallengeData {

    static let all: [DailyChallenge] = [

        // MARK: Variables & Constants
        DailyChallenge(
            question: "Which keyword should you use when a value will never change?",
            options: ["var", "let", "const", "static"],
            correctIndex: 1,
            explanation: "`let` declares a constant — Swift will give you an error if you try to change it later. Use `var` only when the value genuinely needs to change.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What type does Swift infer for `let x = 3.14`?",
            options: ["Float", "Int", "Double", "Number"],
            correctIndex: 2,
            explanation: "Swift infers floating-point literals as `Double` by default, not `Float`. If you want a Float, you must write the type explicitly: `let x: Float = 3.14`.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What will this code print?\n\nvar score = 10\nscore += 5\nprint(score)",
            options: ["10", "5", "15", "Error"],
            correctIndex: 2,
            explanation: "`+=` adds the right value to the variable and stores the result. So `score` goes from 10 to 15.",
            difficulty: "Beginner"
        ),

        // MARK: Types
        DailyChallenge(
            question: "Which of these is a valid Bool value in Swift?",
            options: ["1", "yes", "TRUE", "true"],
            correctIndex: 3,
            explanation: "Swift Booleans are strictly `true` or `false` (lowercase). Unlike some languages, `1`, `yes`, or `TRUE` are not valid Bool values.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What is the type of `let name = \"Swift\"`?",
            options: ["Character", "NSString", "String", "Text"],
            correctIndex: 2,
            explanation: "Text literals in double quotes are inferred as `String`. Swift's `String` is a powerful value type with many built-in methods.",
            difficulty: "Beginner"
        ),

        // MARK: Control Flow
        DailyChallenge(
            question: "What does `guard let` do when the optional is nil?",
            options: [
                "Continues execution normally",
                "Crashes the app",
                "Executes the else branch and exits the current scope",
                "Returns the optional unchanged"
            ],
            correctIndex: 2,
            explanation: "`guard let` requires you to provide an else branch that exits the current scope (via return, throw, break, or continue). It's designed for early exits when a required value is missing.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "A Swift `switch` statement must be...",
            options: [
                "Alphabetically ordered",
                "Exhaustive — all possible values must be covered",
                "Limited to Int values only",
                "Followed by a default case always"
            ],
            correctIndex: 1,
            explanation: "Swift switch statements must cover every possible case. You can use `default:` to catch any remaining cases. This prevents bugs from accidentally missing a case.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What does the ternary operator `a ? b : c` return when `a` is false?",
            options: ["a", "b", "c", "nil"],
            correctIndex: 2,
            explanation: "The ternary evaluates to `b` when the condition is true, and `c` when false. It's a compact version of if/else for simple expressions.",
            difficulty: "Beginner"
        ),

        // MARK: Loops
        DailyChallenge(
            question: "How many times does this loop run?\n\nfor i in 1..<5 { }",
            options: ["5", "4", "6", "3"],
            correctIndex: 1,
            explanation: "The half-open range `..<` excludes the upper bound. `1..<5` generates the values 1, 2, 3, 4 — that's 4 iterations. Use `1...5` (closed range) to include 5.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "Which statement immediately stops a loop?",
            options: ["stop", "continue", "return", "break"],
            correctIndex: 3,
            explanation: "`break` exits the loop entirely. `continue` skips the current iteration but keeps the loop going. `return` exits the entire function, not just the loop.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "A `repeat-while` loop differs from a `while` loop because...",
            options: [
                "It runs faster",
                "It always runs the body at least once",
                "It can only be used with arrays",
                "It doesn't need a condition"
            ],
            correctIndex: 1,
            explanation: "`repeat-while` checks the condition after running the body, so the body always executes at least once. A regular `while` loop checks the condition first and may never run.",
            difficulty: "Intermediate"
        ),

        // MARK: Functions
        DailyChallenge(
            question: "What does the `_` before a parameter name do?",
            options: [
                "Marks the parameter as optional",
                "Makes it private",
                "Removes the argument label at the call site",
                "Gives it a default value of nil"
            ],
            correctIndex: 2,
            explanation: "Using `_` as the external argument label means callers don't write a label. Example: `func square(_ n: Int)` is called as `square(5)` instead of `square(n: 5)`.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What is the return type of this function?\n\nfunc greet(name: String) {\n    print(\"Hi, \\(name)\")\n}",
            options: ["String", "Void", "Nil", "Never"],
            correctIndex: 1,
            explanation: "Functions without an explicit return type return `Void` (also written as `()`). This means they return nothing meaningful.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "Which syntax correctly defines a function with a default parameter?",
            options: [
                "func greet(name: String = \"friend\")",
                "func greet(name: String ?? \"friend\")",
                "func greet(name: String | \"friend\")",
                "func greet(name: String, default: \"friend\")"
            ],
            correctIndex: 0,
            explanation: "Default parameter values are assigned with `=` in the function signature. Callers can omit that argument, and Swift will use the default value automatically.",
            difficulty: "Beginner"
        ),

        // MARK: Optionals
        DailyChallenge(
            question: "What does `??` do in Swift?",
            options: [
                "Checks if two values are equal",
                "Force-unwraps an optional",
                "Returns a default value if the optional is nil",
                "Declares a double optional"
            ],
            correctIndex: 2,
            explanation: "The nil-coalescing operator `??` returns the optional's value if it exists, or the default on the right if it's nil. Example: `username ?? \"Guest\"`.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What happens if you force-unwrap a nil optional with `!`?",
            options: [
                "Returns nil",
                "Returns an empty string",
                "The app crashes at runtime",
                "Swift automatically uses a default value"
            ],
            correctIndex: 2,
            explanation: "Force-unwrapping a nil value causes a fatal error at runtime, crashing your app. Only use `!` when you are absolutely certain the value is not nil.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What is optional chaining `?.` used for?",
            options: [
                "Declaring a chain of optionals",
                "Safely accessing properties on a value that might be nil",
                "Unwrapping multiple optionals at once",
                "Calling functions that return nil"
            ],
            correctIndex: 1,
            explanation: "Optional chaining `?.` lets you access properties or call methods on an optional. If the optional is nil, the whole expression returns nil instead of crashing. Example: `user?.address?.city`.",
            difficulty: "Intermediate"
        ),

        // MARK: Arrays
        DailyChallenge(
            question: "What does `array.append(item)` do?",
            options: [
                "Inserts the item at index 0",
                "Adds the item to the end of the array",
                "Removes and returns the last item",
                "Sorts the array and adds the item in order"
            ],
            correctIndex: 1,
            explanation: "`append` adds one element to the end of the array. The array must be declared with `var`. To insert at a specific position, use `array.insert(item, at: index)`.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What does `filter` return?",
            options: [
                "The first matching element",
                "A Bool indicating whether any element matches",
                "A new array containing only elements that satisfy the condition",
                "The index of the matching element"
            ],
            correctIndex: 2,
            explanation: "`filter` returns a new array with only the elements for which your closure returns true. Example: `[1,2,3,4].filter { $0 > 2 }` returns `[3, 4]`.",
            difficulty: "Intermediate"
        ),

        // MARK: Dictionaries
        DailyChallenge(
            question: "What type does dictionary lookup return?\n\nlet ages = [\"Alice\": 30]\nlet age = ages[\"Alice\"]",
            options: ["Int", "Int?", "Any", "Optional<Any>"],
            correctIndex: 1,
            explanation: "Dictionary subscript access always returns an optional because the key might not exist. Here `age` is `Int?`, not `Int`. You must unwrap it before using it.",
            difficulty: "Intermediate"
        ),

        // MARK: Structs
        DailyChallenge(
            question: "Why must a struct method be marked `mutating` to change a property?",
            options: [
                "It's a Swift style requirement with no technical reason",
                "Structs are value types — Swift must mark methods that modify self to make copies explicit",
                "Only classes can modify properties",
                "mutating is required for all methods"
            ],
            correctIndex: 1,
            explanation: "Structs are value types. When you modify a struct, Swift actually replaces the whole value. The `mutating` keyword tells the compiler (and readers) that this method will modify the struct's properties.",
            difficulty: "Intermediate"
        ),
        DailyChallenge(
            question: "Structs in Swift...",
            options: [
                "Support inheritance",
                "Are reference types",
                "Are value types and are copied when assigned",
                "Must have a custom initializer"
            ],
            correctIndex: 2,
            explanation: "Structs are value types. When you assign a struct to a new variable or pass it to a function, Swift creates a copy. Changes to the copy don't affect the original. Classes behave oppositely — they're reference types.",
            difficulty: "Intermediate"
        ),

        // MARK: Classes
        DailyChallenge(
            question: "What keyword do you use to override a parent class method?",
            options: ["super", "extends", "override", "replace"],
            correctIndex: 2,
            explanation: "`override` tells Swift you're intentionally replacing a method from the parent class. Xcode gives a compile error if you forget it when overriding, preventing accidental method shadowing.",
            difficulty: "Beginner"
        ),

        // MARK: Protocols
        DailyChallenge(
            question: "What does it mean for a type to 'conform to a protocol'?",
            options: [
                "It inherits from that protocol",
                "It copies the protocol's code",
                "It implements all the required properties and methods defined by the protocol",
                "It registers with the Swift runtime"
            ],
            correctIndex: 2,
            explanation: "Conforming to a protocol means your type provides everything the protocol requires. Protocols define a contract — they don't provide implementations (except through extensions with default implementations).",
            difficulty: "Intermediate"
        ),
        DailyChallenge(
            question: "Which protocol does SwiftUI's `ForEach` and `List` require list items to conform to?",
            options: ["Equatable", "Hashable", "Codable", "Identifiable"],
            correctIndex: 3,
            explanation: "`Identifiable` requires a unique `id` property. SwiftUI uses this to track each item across redraws. You can also use `id: \\.self` in ForEach if your type is Hashable.",
            difficulty: "Intermediate"
        ),

        // MARK: Closures
        DailyChallenge(
            question: "In a closure, what does `$0` refer to?",
            options: [
                "The closure itself",
                "The first argument passed to the closure",
                "The return value",
                "The index of the current element"
            ],
            correctIndex: 1,
            explanation: "$0 is shorthand for the first argument, $1 for the second, etc. These shorthand argument names let you write concise closures: `numbers.map { $0 * 2 }` instead of `numbers.map { number in number * 2 }`.",
            difficulty: "Intermediate"
        ),
        DailyChallenge(
            question: "What is a trailing closure syntax?",
            options: [
                "A closure that captures self",
                "A closure written after the function's closing parenthesis when it's the last argument",
                "A closure that returns another closure",
                "A closure declared with @escaping"
            ],
            correctIndex: 1,
            explanation: "When a closure is the final argument, you can write it after the `()`: `button.action { doSomething() }`. SwiftUI relies heavily on this — most view builders use trailing closure syntax.",
            difficulty: "Intermediate"
        ),

        // MARK: Enums
        DailyChallenge(
            question: "How do you access an enum case?",
            options: [
                "EnumName[caseName]",
                "EnumName.caseName",
                "EnumName->caseName",
                "caseName()"
            ],
            correctIndex: 1,
            explanation: "Enum cases are accessed with dot notation: `Direction.north`, `Status.loading`. When the type is known from context, you can abbreviate: `.north` instead of `Direction.north`.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What is a raw value enum?",
            options: [
                "An enum with no cases",
                "An enum whose cases each have an associated underlying value of the same type",
                "An enum stored in UserDefaults",
                "An enum that can change values at runtime"
            ],
            correctIndex: 1,
            explanation: "Raw value enums associate a concrete value with each case: `enum Direction: String { case north = \"N\", south = \"S\" }`. Use `direction.rawValue` to get the raw value, or `Direction(rawValue:)` to create one.",
            difficulty: "Intermediate"
        ),

        // MARK: Error Handling
        DailyChallenge(
            question: "What keyword marks a function that can throw an error?",
            options: ["catch", "throws", "try", "error"],
            correctIndex: 1,
            explanation: "`throws` in the function signature signals that the function might throw an error. Callers must use `try` when calling it, and wrap the call in `do-catch` to handle errors.",
            difficulty: "Intermediate"
        ),
        DailyChallenge(
            question: "What is the purpose of `try?`?",
            options: [
                "It makes the function optional",
                "It calls the function without error handling",
                "It returns nil if the function throws instead of propagating the error",
                "It retries the function if it fails"
            ],
            correctIndex: 2,
            explanation: "`try?` converts a throwing function call into an optional. If it succeeds, you get the value wrapped in an optional. If it throws, you get nil. It's useful when you want to ignore specific errors.",
            difficulty: "Intermediate"
        ),

        // MARK: SwiftUI
        DailyChallenge(
            question: "In SwiftUI, what does `@State` do?",
            options: [
                "Stores data persistently in UserDefaults",
                "Marks a property as immutable",
                "Creates a source of truth for a view — when it changes, the view redraws",
                "Shares state between all views in the app"
            ],
            correctIndex: 2,
            explanation: "`@State` tells SwiftUI to watch a property and redraw the view whenever it changes. It's intended for simple local view state. For shared state, use `@StateObject` or `@EnvironmentObject`.",
            difficulty: "Beginner"
        ),
        DailyChallenge(
            question: "What does the `$` prefix do in SwiftUI? Example: `$username`",
            options: [
                "Converts the value to a String",
                "Creates a Binding to the @State property",
                "Accesses the stored value directly",
                "Marks the value as a constant"
            ],
            correctIndex: 1,
            explanation: "The `$` prefix creates a `Binding` to a `@State` property. A Binding is a two-way connection — the child view can both read and write the parent's state. Example: `TextField(\"Name\", text: $username)`.",
            difficulty: "Intermediate"
        ),
    ]

    static var todayIndex: Int {
        let cal       = Calendar.current
        let dayOfYear = cal.ordinality(of: .day, in: .year, for: Date()) ?? 1
        return dayOfYear % all.count
    }

    static var today: DailyChallenge {
        all[todayIndex]
    }
}
