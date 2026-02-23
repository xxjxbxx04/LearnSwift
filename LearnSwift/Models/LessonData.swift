import Foundation

// MARK: - LessonData
// Contains every lesson, organized into 6 sections.

struct LessonData {

    // Flat list of every lesson across all sections.
    static var all: [Lesson] { sections.flatMap { $0.lessons } }

    // All sections in curriculum order.
    static let sections: [LessonSection] = [
        section1, section2, section3, section4, section5, section6
    ]

    // =========================================================
    // MARK: - SECTION 1: Swift Basics
    // =========================================================

    static let section1 = LessonSection(
        id: 1,
        title: "Swift Basics",
        emoji: "📗",
        description: "The essential building blocks of every Swift program.",
        lessons: [l01, l02, l03, l04, l05, l06, l07, l08]
    )

    // ── Lesson 1 ──────────────────────────────────────────────
    static let l01 = Lesson(
        id: 1,
        title: "Variables & Constants",
        subtitle: "Store and manage values in Swift",
        emoji: "📦",
        difficulty: .beginner,
        estimatedMinutes: 5,
        sections: [
            ContentSection(
                heading: "What is a Variable?",
                body: "A variable is a named storage location whose value can change. Declare one with the `var` keyword.",
                codeExample: """
var playerName = "Alex"
var score = 0
score = 10          // ✅ var can change
playerName = "Sam"  // ✅ var can change
"""
            ),
            ContentSection(
                heading: "What is a Constant?",
                body: "A constant's value never changes after it is first set. Use `let`. Swift prefers constants — always use `let` unless you know the value will change.",
                codeExample: """
let maxLives = 3
let appName  = "LearnSwift"
// maxLives = 5  ❌ ERROR – cannot change a constant
"""
            ),
            ContentSection(
                heading: "Type Inference",
                body: "Swift figures out the type from the value you assign. You can also write the type explicitly after a colon.",
                codeExample: """
var age = 25            // Swift infers Int
var price = 9.99        // Swift infers Double
var isHappy = true      // Swift infers Bool
var city: String = "New York"  // explicit type
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "Which keyword declares a value that CANNOT change?",
                         options: ["var", "let", "def", "val"], correctIndex: 1,
                         explanation: "`let` creates a constant. Once set, it cannot be reassigned."),
            QuizQuestion(question: "What happens if you run: let x = 5; x = 10?",
                         options: ["x becomes 10", "x stays 5", "A compile-time error", "A runtime crash"],
                         correctIndex: 2, explanation: "Constants cannot be reassigned — Xcode shows a compile error."),
            QuizQuestion(question: "What type does Swift infer for: var temperature = 98.6?",
                         options: ["Int", "Float", "Double", "String"], correctIndex: 2,
                         explanation: "Swift infers `Double` for decimal literals by default.")
        ]
    )

    // ── Lesson 2 ──────────────────────────────────────────────
    static let l02 = Lesson(
        id: 2,
        title: "Data Types",
        subtitle: "Understand Int, String, Bool, Double & more",
        emoji: "🔢",
        difficulty: .beginner,
        estimatedMinutes: 6,
        sections: [
            ContentSection(
                heading: "Int – Whole Numbers",
                body: "Use `Int` for whole numbers. Underscores improve readability for large numbers.",
                codeExample: """
var lives: Int = 3
var distance = 1_000_000  // same as 1000000
var temperature = -5
"""
            ),
            ContentSection(
                heading: "Double – Decimal Numbers",
                body: "`Double` stores numbers with a decimal point. It is more precise than `Float` and is Swift's default for decimals.",
                codeExample: """
var height: Double = 1.75
var pi = 3.14159
var bankBalance = 1_234.56
"""
            ),
            ContentSection(
                heading: "String & Bool",
                body: "`String` stores text in double quotes. Use string interpolation `\\(value)` to embed values. `Bool` is either `true` or `false`.",
                codeExample: """
var name = "Jeremy"
var greeting = "Hello, \\(name)!"  // interpolation

var isLoggedIn: Bool = false
isLoggedIn = true
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "Which type stores text?",
                         options: ["Int", "Bool", "String", "Double"], correctIndex: 2,
                         explanation: "`String` is used for text values."),
            QuizQuestion(question: "What is the value of: var r = \"Score: \\(5 * 2)\"?",
                         options: ["Score: 5 * 2", "Score: 10", "Score: \\(10)", "Compile error"],
                         correctIndex: 1, explanation: "String interpolation evaluates the expression and embeds the result."),
            QuizQuestion(question: "What is Swift's default decimal type?",
                         options: ["Float", "Double", "Decimal", "Number"], correctIndex: 1,
                         explanation: "Swift defaults to `Double` for floating-point literals.")
        ]
    )

    // ── Lesson 3 ──────────────────────────────────────────────
    static let l03 = Lesson(
        id: 3,
        title: "Control Flow",
        subtitle: "Make decisions with if, else & switch",
        emoji: "🔀",
        difficulty: .beginner,
        estimatedMinutes: 7,
        sections: [
            ContentSection(
                heading: "if / else if / else",
                body: "Run a block of code only when a condition is true. Chain `else if` for multiple branches and `else` for the fallback.",
                codeExample: """
var score = 75

if score >= 90 {
    print("Grade: A")
} else if score >= 70 {
    print("Grade: B")
} else {
    print("Grade: C or below")
}
// Prints: Grade: B
"""
            ),
            ContentSection(
                heading: "Comparison Operators",
                body: "Use these to compare values inside conditions: `==` equal, `!=` not equal, `>`, `<`, `>=`, `<=`.",
                codeExample: """
var x = 10
print(x == 10)  // true
print(x != 5)   // true
print(x > 15)   // false
print(x <= 10)  // true
"""
            ),
            ContentSection(
                heading: "switch Statement",
                body: "`switch` is cleaner than many `else if` chains. Every possible value must be covered — use `default` to catch the rest. Unlike many languages, Swift cases do NOT fall through automatically.",
                codeExample: """
let day = "Monday"

switch day {
case "Saturday", "Sunday":
    print("Weekend!")
case "Monday":
    print("Back to work.")
default:
    print("A weekday.")
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What operator checks if two values are equal?",
                         options: ["=", "==", "!=", "=>"], correctIndex: 1,
                         explanation: "`==` is equality. A single `=` is assignment, not comparison."),
            QuizQuestion(question: "What does `default` do in a switch?",
                         options: ["Always runs first", "Runs when no case matches", "Makes switch optional", "Stops the switch"],
                         correctIndex: 1, explanation: "`default` matches anything not covered by a specific `case`."),
            QuizQuestion(question: "What prints? if 5 > 3 { print(\"yes\") } else { print(\"no\") }",
                         options: ["no", "yes", "5", "3"], correctIndex: 1,
                         explanation: "5 > 3 is true, so the if-branch runs and prints \"yes\".")
        ]
    )

    // ── Lesson 4 ──────────────────────────────────────────────
    static let l04 = Lesson(
        id: 4,
        title: "Loops",
        subtitle: "Repeat code with for and while",
        emoji: "🔁",
        difficulty: .beginner,
        estimatedMinutes: 7,
        sections: [
            ContentSection(
                heading: "for-in Loop",
                body: "Iterate over a range or collection. Use `...` for a closed range (includes both ends) and `..<` for a half-open range (excludes the upper bound).",
                codeExample: """
for i in 1...5 { print(i) }  // 1 2 3 4 5

for i in 0..<3 { print(i) }  // 0 1 2

let fruits = ["Apple", "Banana", "Cherry"]
for fruit in fruits { print(fruit) }
"""
            ),
            ContentSection(
                heading: "while & repeat-while",
                body: "`while` checks the condition before each iteration. `repeat-while` runs the body first, then checks — so it always runs at least once.",
                codeExample: """
var count = 0
while count < 3 {
    print("Tick \\(count)")
    count += 1
}

var n = 5
repeat {
    print(n)
    n -= 1
} while n > 0
"""
            ),
            ContentSection(
                heading: "break & continue",
                body: "`break` exits the loop immediately. `continue` skips the rest of the current iteration and moves to the next one.",
                codeExample: """
for n in 1...10 {
    if n == 6 { break }         // stop here
    if n % 2 == 0 { continue }  // skip evens
    print(n)  // prints 1, 3, 5
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "How many times does `for i in 1...4 { }` run?",
                         options: ["3", "4", "5", "0"], correctIndex: 1,
                         explanation: "`1...4` includes 1, 2, 3, and 4 — that's 4 iterations."),
            QuizQuestion(question: "What does `continue` do in a loop?",
                         options: ["Exits the loop", "Skips to the next iteration", "Restarts the loop", "Pauses the loop"],
                         correctIndex: 1, explanation: "`continue` skips remaining code in the current iteration."),
            QuizQuestion(question: "What range does `0..<5` represent?",
                         options: ["0 to 5 inclusive", "0 to 4 inclusive", "1 to 5 inclusive", "1 to 4 inclusive"],
                         correctIndex: 1, explanation: "`..<` excludes the upper bound. So 0, 1, 2, 3, 4.")
        ]
    )

    // ── Lesson 5 ──────────────────────────────────────────────
    static let l05 = Lesson(
        id: 5,
        title: "Functions",
        subtitle: "Reusable, named blocks of code",
        emoji: "⚙️",
        difficulty: .beginner,
        estimatedMinutes: 8,
        sections: [
            ContentSection(
                heading: "Defining & Calling Functions",
                body: "Use `func` to define a function. Give it a name, optional parameters in parentheses, and an optional return type after `->`.",
                codeExample: """
func greet(name: String) {
    print("Hello, \\(name)!")
}
greet(name: "Jeremy")  // Hello, Jeremy!

func add(a: Int, b: Int) -> Int {
    return a + b
}
let result = add(a: 3, b: 4)  // 7
"""
            ),
            ContentSection(
                heading: "Argument Labels",
                body: "Functions can have an external label (used when calling) and an internal name (used inside). Use `_` to omit the external label entirely.",
                codeExample: """
// External: "for", internal: "person"
func makeGreeting(for person: String) -> String {
    "Welcome, \\(person)!"
}
let msg = makeGreeting(for: "Sam")  // reads naturally

// No external label with _
func square(_ n: Int) -> Int { n * n }
let s = square(5)  // no label needed
"""
            ),
            ContentSection(
                heading: "Default & Multiple Return Values",
                body: "Give parameters a default value so callers can omit them. Return multiple values using a tuple.",
                codeExample: """
func greet(_ name: String, loudly: Bool = false) {
    let msg = "Hello, \\(name)!"
    print(loudly ? msg.uppercased() : msg)
}
greet("Alex")           // Hello, Alex!
greet("Alex", loudly: true) // HELLO, ALEX!

func minMax(_ arr: [Int]) -> (min: Int, max: Int) {
    (arr.min()!, arr.max()!)
}
let r = minMax([3,1,9,2])
print(r.min, r.max)  // 1 9
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What keyword defines a function in Swift?",
                         options: ["def", "function", "func", "fn"], correctIndex: 2,
                         explanation: "Swift uses the `func` keyword."),
            QuizQuestion(question: "What symbol shows a function's return type?",
                         options: ["=>", "->", ":", "::"], correctIndex: 1,
                         explanation: "`->` indicates the return type, e.g. `func getName() -> String`."),
            QuizQuestion(question: "What does `_` as an argument label mean?",
                         options: ["Optional param", "No external label", "Private param", "Unused param"],
                         correctIndex: 1, explanation: "Using `_` means callers don't need a label: `myFunc(42)` instead of `myFunc(value: 42)`.")
        ]
    )

    // ── Lesson 6 ──────────────────────────────────────────────
    static let l06 = Lesson(
        id: 6,
        title: "Arrays & Dictionaries",
        subtitle: "Store ordered lists and key-value pairs",
        emoji: "📚",
        difficulty: .beginner,
        estimatedMinutes: 8,
        sections: [
            ContentSection(
                heading: "Arrays",
                body: "Arrays store an ordered list of same-type values. Indices start at 0. Use `append` to add, `remove(at:)` to delete.",
                codeExample: """
var colors = ["Red", "Green", "Blue"]
print(colors[0])       // Red
print(colors.count)    // 3
colors.append("Yellow")
colors.remove(at: 1)   // removes "Green"
"""
            ),
            ContentSection(
                heading: "Dictionaries",
                body: "Dictionaries store key-value pairs. Keys must be unique. Access with `dict[key]` which returns an Optional.",
                codeExample: """
var ages = ["Alice": 30, "Bob": 25]
print(ages["Alice"] ?? 0)  // 30
ages["Carol"] = 28          // add
ages["Bob"] = 26            // update

for (name, age) in ages {
    print("\\(name): \\(age)")
}
"""
            ),
            ContentSection(
                heading: "Useful Collection Methods",
                body: "Collections come with powerful built-in methods like `sorted()`, `map()`, `filter()`, `contains()`, `first`, and `last`.",
                codeExample: """
let nums = [3, 1, 4, 1, 5, 9, 2, 6]
let sorted  = nums.sorted()          // [1,1,2,3,4,5,6,9]
let doubled = nums.map { $0 * 2 }   // [6,2,8,...]
let evens   = nums.filter { $0 % 2 == 0 } // [4,2,6]
let total   = nums.reduce(0, +)     // 31
print(nums.contains(9))             // true
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What index does the first array element have?",
                         options: ["1", "0", "-1", "It depends"], correctIndex: 1,
                         explanation: "Arrays are zero-indexed. First element = index 0."),
            QuizQuestion(question: "How do you add an element to the end of a Swift array?",
                         options: ["add()", "push()", "append()", "insert()"], correctIndex: 2,
                         explanation: "`append(_:)` adds an element to the end."),
            QuizQuestion(question: "In a dictionary, what must be unique?",
                         options: ["Values", "Keys", "Both", "Neither"], correctIndex: 1,
                         explanation: "Dictionary keys must be unique. Values can repeat.")
        ]
    )

    // ── Lesson 7 ──────────────────────────────────────────────
    static let l07 = Lesson(
        id: 7,
        title: "Optionals",
        subtitle: "Safely handle values that might be missing",
        emoji: "❓",
        difficulty: .beginner,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "What is an Optional?",
                body: "An optional can hold a value OR `nil` (nothing). Add `?` after the type. This forces you to handle the \"no value\" case explicitly — no hidden null crashes!",
                codeExample: """
var username: String? = nil  // no value
username = "jeremy"          // now has a value

var score: Int? = 42
var empty: Int? = nil
"""
            ),
            ContentSection(
                heading: "Unwrapping: if let & guard let",
                body: "`if let` safely unwraps an optional — the block only runs if a value exists. `guard let` is the opposite: exit early if nil, continue if there's a value.",
                codeExample: """
var name: String? = "Alex"

// if let
if let n = name {
    print("Hello, \\(n)!")
} else {
    print("No name.")
}

// guard let (common in functions)
func greet(_ name: String?) {
    guard let n = name else {
        print("No name provided.")
        return
    }
    print("Hello, \\(n)!")
}
"""
            ),
            ContentSection(
                heading: "Nil Coalescing ?? & Optional Chaining",
                body: "`??` provides a default value if the optional is nil. Optional chaining `?.` lets you call methods on an optional without crashing — it returns nil if the optional is nil.",
                codeExample: """
var nickname: String? = nil
let display = nickname ?? "Guest"  // "Guest"

var score: Int? = 85
let final = score ?? 0  // 85

// Optional chaining
var text: String? = "hello"
let upper = text?.uppercased()  // Optional("HELLO")
let count = text?.count         // Optional(5)
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What symbol makes a type optional?",
                         options: ["!", "?", "*", "@"], correctIndex: 1,
                         explanation: "`String?` is an optional String — it can be nil."),
            QuizQuestion(question: "What does `??` do?",
                         options: ["Force-unwraps", "Compares optionals", "Provides a default if nil", "Converts to non-optional"],
                         correctIndex: 2, explanation: "`optional ?? default` returns the value if present, otherwise `default`."),
            QuizQuestion(question: "What does `nil` represent?",
                         options: ["Zero", "False", "Empty string", "The absence of a value"],
                         correctIndex: 3, explanation: "`nil` means no value at all — different from 0, false, or \"\".")
        ]
    )

    // ── Lesson 8 ──────────────────────────────────────────────
    static let l08 = Lesson(
        id: 8,
        title: "Structs & Classes",
        subtitle: "Create your own custom types",
        emoji: "🏗️",
        difficulty: .beginner,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "Structs – Value Types",
                body: "A `struct` groups related values. Structs are value types — copying one creates an independent copy. Most Swift data models are structs.",
                codeExample: """
struct Point {
    var x: Double
    var y: Double

    func distanceToOrigin() -> Double {
        (x * x + y * y).squareRoot()
    }
}

var p1 = Point(x: 3, y: 4)
print(p1.distanceToOrigin())  // 5.0
var p2 = p1   // independent copy
p2.x = 10    // p1.x is still 3
"""
            ),
            ContentSection(
                heading: "Classes – Reference Types",
                body: "A `class` is a reference type — multiple variables can point to the same object. Classes support inheritance (covered later).",
                codeExample: """
class BankAccount {
    var balance: Double
    let owner: String

    init(owner: String, balance: Double) {
        self.owner = owner
        self.balance = balance
    }

    func deposit(_ amount: Double) {
        balance += amount
    }
}

let acc = BankAccount(owner: "Jeremy", balance: 100)
acc.deposit(50)
print(acc.balance)  // 150.0
"""
            ),
            ContentSection(
                heading: "Struct vs Class – When to Use Each",
                body: "Use a **struct** for simple data (coordinates, config, records). Use a **class** when you need shared mutable state, inheritance, or a specific lifecycle.",
                codeExample: """
// ✅ Struct — independent copies, simple data
struct Color { var r, g, b: Double }

// ✅ Class — shared state, inheritance
class ViewController {
    var title = "Home"
}

// In SwiftUI: data models are structs,
//             views are structs too!
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "Are structs value types or reference types?",
                         options: ["Reference types", "Value types", "Both", "Neither"], correctIndex: 1,
                         explanation: "Structs are value types. Copying creates an independent copy."),
            QuizQuestion(question: "Which feature do classes have that structs do NOT?",
                         options: ["Properties", "Methods", "Inheritance", "Initializers"], correctIndex: 2,
                         explanation: "Classes support inheritance; structs cannot inherit from other types."),
            QuizQuestion(question: "What keyword sets up a class instance in Swift?",
                         options: ["constructor", "init", "setup", "new"], correctIndex: 1,
                         explanation: "`init` is the initializer method in Swift.")
        ]
    )

    // =========================================================
    // MARK: - SECTION 2: Types, Strings & Operators
    // =========================================================

    static let section2 = LessonSection(
        id: 2,
        title: "Types, Strings & Operators",
        emoji: "🔧",
        description: "Go deeper on strings, tuples, sets, operators, enums, and closures.",
        lessons: [l09, l10, l11, l12, l13, l14]
    )

    // ── Lesson 9 ──────────────────────────────────────────────
    static let l09 = Lesson(
        id: 9,
        title: "Strings In-Depth",
        subtitle: "Everything about text in Swift",
        emoji: "📝",
        difficulty: .beginner,
        estimatedMinutes: 8,
        sections: [
            ContentSection(
                heading: "Common String Methods",
                body: "Swift strings have dozens of built-in methods for inspecting and transforming text.",
                codeExample: """
var s = "  Hello, Swift!  "
print(s.uppercased())     // "  HELLO, SWIFT!  "
print(s.lowercased())     // "  hello, swift!  "
print(s.trimmingCharacters(in: .whitespaces))
                          // "Hello, Swift!"
print(s.contains("Swift"))   // true
print(s.hasPrefix("  Hel"))  // true
print(s.hasSuffix("!  "))    // true
print(s.count)               // 17
"""
            ),
            ContentSection(
                heading: "Modifying Strings",
                body: "Strings in Swift are value types. Modifying one creates a new string (or use a `var` and mutate in place).",
                codeExample: """
var sentence = "I love cats"
sentence = sentence.replacingOccurrences(of: "cats", with: "Swift")
print(sentence)  // "I love Swift"

let words = sentence.split(separator: " ")
print(words)     // ["I", "love", "Swift"]
let rejoined = words.joined(separator: "-")
print(rejoined)  // "I-love-Swift"

// Multi-line string
let poem = \"\"\"
    Roses are red,
    Swift is great.
    \"\"\"
"""
            ),
            ContentSection(
                heading: "String Interpolation & Formatting",
                body: "Embed any expression inside a string using `\\(expression)`. For precise formatting use `String(format:, ...)`.",
                codeExample: """
let name = "Alex"
let score = 98.5
let msg = "\\(name) scored \\(score)%"
// "Alex scored 98.5%"

// Pad a number to 2 digits
let hour = 9
let formatted = String(format: "%02d:00", hour)
print(formatted)  // "09:00"

// Limit decimal places
let pi = 3.14159
print(String(format: "%.2f", pi))  // "3.14"
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does `.uppercased()` do?",
                         options: ["Removes spaces", "Converts to uppercase", "Capitalises first letter", "Reverses the string"],
                         correctIndex: 1, explanation: "`.uppercased()` returns a new string with all letters uppercase."),
            QuizQuestion(question: "What does `contains(_:)` return?",
                         options: ["The index of the match", "A Bool", "The matched substring", "An optional String"],
                         correctIndex: 1, explanation: "`contains` returns `true` if the substring is found, `false` otherwise."),
            QuizQuestion(question: "How do you embed a variable inside a String?",
                         options: ["#{variable}", "${variable}", "\\(variable)", "@(variable)"],
                         correctIndex: 2, explanation: "Swift uses `\\(variable)` for string interpolation.")
        ]
    )

    // ── Lesson 10 ──────────────────────────────────────────────
    static let l10 = Lesson(
        id: 10,
        title: "Tuples",
        subtitle: "Group multiple values into one",
        emoji: "🎁",
        difficulty: .beginner,
        estimatedMinutes: 5,
        sections: [
            ContentSection(
                heading: "What is a Tuple?",
                body: "A tuple groups multiple values of any types into a single compound value. Access elements with `.0`, `.1`, etc.",
                codeExample: """
let point = (10, 20)
print(point.0)  // 10
print(point.1)  // 20

let http = (404, "Not Found")
print("Status: \\(http.0) \\(http.1)")
"""
            ),
            ContentSection(
                heading: "Named Tuples",
                body: "Give each element a name for clarity. Access them with dot notation.",
                codeExample: """
let coords = (x: 3.5, y: -1.2)
print(coords.x)  // 3.5
print(coords.y)  // -1.2

func getUser() -> (name: String, age: Int) {
    return (name: "Sam", age: 28)
}
let user = getUser()
print(user.name)  // Sam
"""
            ),
            ContentSection(
                heading: "Decomposing Tuples",
                body: "Break a tuple apart into individual variables. Use `_` to ignore elements you don't need.",
                codeExample: """
let minMax = (min: 1, max: 99)
let (lo, hi) = minMax
print(lo)  // 1
print(hi)  // 99

// Ignore parts you don't need
let (_, maximum) = minMax
print(maximum)  // 99

// Works great with for-in on dictionaries
let scores = ["Alice": 95, "Bob": 80]
for (name, score) in scores {
    print("\\(name): \\(score)")
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "How do you access the first element of unnamed tuple `t`?",
                         options: ["t[0]", "t.first", "t.0", "t.get(0)"], correctIndex: 2,
                         explanation: "Unnamed tuple elements are accessed with `.0`, `.1`, `.2`, etc."),
            QuizQuestion(question: "Can a tuple hold different types?",
                         options: ["No, all same type", "Yes, any types", "Only Int and String", "Only up to 2 types"],
                         correctIndex: 1, explanation: "Tuples can mix any types: `(Int, String, Bool)` is valid."),
            QuizQuestion(question: "What does `_` mean when decomposing a tuple?",
                         options: ["Private element", "Ignore that element", "Optional element", "Required element"],
                         correctIndex: 1, explanation: "`_` means \"I don't need this value\" — it skips binding that element.")
        ]
    )

    // ── Lesson 11 ──────────────────────────────────────────────
    static let l11 = Lesson(
        id: 11,
        title: "All About Operators",
        subtitle: "Arithmetic, logical, ternary & range",
        emoji: "🧮",
        difficulty: .beginner,
        estimatedMinutes: 7,
        sections: [
            ContentSection(
                heading: "Arithmetic & Compound Assignment",
                body: "Standard math operators. Compound assignment combines an operator with `=` to update a variable in place.",
                codeExample: """
var x = 10
x += 5   // x = 15
x -= 3   // x = 12
x *= 2   // x = 24
x /= 4   // x = 6
x %= 4   // x = 2  (remainder)

// Integer vs floating-point division
print(7 / 2)    // 3  (Int division, truncates)
print(7.0 / 2)  // 3.5
"""
            ),
            ContentSection(
                heading: "Comparison & Logical Operators",
                body: "Comparison operators return `Bool`. Logical operators combine booleans.",
                codeExample: """
// Comparison
5 == 5   // true  (equal)
5 != 3   // true  (not equal)
5 > 3    // true
5 < 3    // false
5 >= 5   // true
5 <= 4   // false

// Logical
true && false  // false (AND – both must be true)
true || false  // true  (OR  – at least one true)
!true          // false (NOT – inverts)

// Combined
let age = 20
let hasID = true
if age >= 18 && hasID {
    print("Access granted")
}
"""
            ),
            ContentSection(
                heading: "Ternary & Range Operators",
                body: "The ternary operator is a compact if/else. Range operators create sequences of values.",
                codeExample: """
// Ternary: condition ? valueIfTrue : valueIfFalse
let score = 72
let grade = score >= 60 ? "Pass" : "Fail"
print(grade)  // Pass

// Ranges
1...5     // closed: 1,2,3,4,5
1..<5     // half-open: 1,2,3,4
...5      // one-sided: up to 5
5...      // one-sided: 5 and above

let letters = "abcdefg"
print(letters[letters.startIndex...])  // abcdefg
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does the `%` operator do?",
                         options: ["Percentage", "Division", "Remainder/modulo", "Power"],
                         correctIndex: 2, explanation: "`%` returns the remainder after division. `7 % 3` equals `1`."),
            QuizQuestion(question: "What does `&&` mean?",
                         options: ["Logical OR", "Logical AND", "Bitwise AND", "String concatenation"],
                         correctIndex: 1, explanation: "`&&` is logical AND — both sides must be true."),
            QuizQuestion(question: "What does `...` vs `..<` create?",
                         options: ["Same thing", "Closed range vs half-open range", "Half-open vs closed", "Both exclude endpoints"],
                         correctIndex: 1, explanation: "`...` is a closed range (includes both ends). `..<` excludes the upper bound.")
        ]
    )

    // ── Lesson 12 ──────────────────────────────────────────────
    static let l12 = Lesson(
        id: 12,
        title: "Sets",
        subtitle: "Unordered collections of unique values",
        emoji: "🔵",
        difficulty: .beginner,
        estimatedMinutes: 6,
        sections: [
            ContentSection(
                heading: "Creating & Using Sets",
                body: "A `Set` stores unique values with no defined order. You must write the type `Set<T>` explicitly because the literal looks the same as an array.",
                codeExample: """
var fruits: Set<String> = ["Apple", "Banana", "Cherry"]
fruits.insert("Apple")    // duplicate – ignored
print(fruits.count)       // still 3

print(fruits.contains("Banana"))  // true
fruits.remove("Cherry")
print(fruits)             // {"Apple", "Banana"} (order varies)

// Check membership quickly – O(1) vs Array's O(n)
"""
            ),
            ContentSection(
                heading: "Set Algebra",
                body: "Sets support mathematical operations: union (all elements), intersection (common), subtracting (difference), and symmetric difference (elements in one but not both).",
                codeExample: """
let setA: Set = [1, 2, 3, 4]
let setB: Set = [3, 4, 5, 6]

let union        = setA.union(setB)        // {1,2,3,4,5,6}
let intersection = setA.intersection(setB) // {3,4}
let difference   = setA.subtracting(setB)  // {1,2}
let symDiff      = setA.symmetricDifference(setB) // {1,2,5,6}

print(setA.isSubset(of: union))   // true
"""
            ),
            ContentSection(
                heading: "Set vs Array — When to Choose",
                body: "Use a Set when order doesn't matter and you need fast lookup or uniqueness. Use an Array when order matters or you need indexed access.",
                codeExample: """
// ✅ Set  – fast membership check, uniqueness
var visitedURLs: Set<String> = []
visitedURLs.insert("https://swift.org")

// ✅ Array – ordered, allows duplicates
var playlist: [String] = ["Song A", "Song B", "Song A"]

// Converting between them
let unique = Array(Set(playlist))
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "Can a Set contain duplicate values?",
                         options: ["Yes always", "No, duplicates are ignored", "Only if the type conforms to Equatable", "Depends on how it's declared"],
                         correctIndex: 1, explanation: "Sets only store unique values. Inserting a duplicate has no effect."),
            QuizQuestion(question: "What does `union` return?",
                         options: ["Common elements only", "All elements from both sets", "Elements in first but not second", "A sorted array"],
                         correctIndex: 1, explanation: "`union` returns a new set containing all elements from both sets."),
            QuizQuestion(question: "Why might you choose a Set over an Array?",
                         options: ["Sets preserve order", "Sets allow faster lookup and enforce uniqueness", "Sets use less memory always", "Sets support indexing"],
                         correctIndex: 1, explanation: "Set membership checks are O(1); arrays are O(n). Sets also guarantee uniqueness.")
        ]
    )

    // ── Lesson 13 ──────────────────────────────────────────────
    static let l13 = Lesson(
        id: 13,
        title: "Enumerations",
        subtitle: "Model a fixed set of related values",
        emoji: "🗂️",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Basic Enums & Raw Values",
                body: "An `enum` defines a type with a fixed set of named cases. Assign raw values (Int, String, etc.) and create instances from them.",
                codeExample: """
enum Direction {
    case north, south, east, west
}
var heading = Direction.north
heading = .east  // shorthand once type is known

// Raw values
enum Planet: Int {
    case mercury = 1, venus, earth, mars
}
let earth = Planet(rawValue: 3)  // .earth
print(Planet.mars.rawValue)       // 4

enum Status: String {
    case active = "Active"
    case inactive = "Inactive"
}
"""
            ),
            ContentSection(
                heading: "Associated Values",
                body: "Cases can carry extra data — called associated values. This is one of Swift's most powerful features.",
                codeExample: """
enum Barcode {
    case qr(String)
    case upc(Int, Int, Int, Int)
}

var code = Barcode.qr("ABCDEF")
code = .upc(8, 85909, 51226, 3)

switch code {
case .qr(let value):
    print("QR: \\(value)")
case .upc(let a, let b, let c, let d):
    print("UPC: \\(a)-\\(b)-\\(c)-\\(d)")
}
"""
            ),
            ContentSection(
                heading: "CaseIterable & Enum Methods",
                body: "Conform to `CaseIterable` to iterate over all cases. Add computed properties and methods just like a struct.",
                codeExample: """
enum Season: String, CaseIterable {
    case spring, summer, autumn, winter

    var isWarm: Bool {
        self == .spring || self == .summer
    }

    func describe() -> String {
        "It's \\(rawValue). Warm: \\(isWarm)"
    }
}

for season in Season.allCases {
    print(season.describe())
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What keyword defines an enum?",
                         options: ["struct", "class", "enum", "type"], correctIndex: 2,
                         explanation: "`enum` is the keyword for defining an enumeration in Swift."),
            QuizQuestion(question: "What is an associated value?",
                         options: ["The raw Int value of a case", "Extra data attached to a specific case", "A default case", "A computed property"],
                         correctIndex: 1, explanation: "Associated values let each case carry additional data of any type."),
            QuizQuestion(question: "What protocol lets you iterate over all enum cases?",
                         options: ["Equatable", "Hashable", "CaseIterable", "Codable"], correctIndex: 2,
                         explanation: "Conforming to `CaseIterable` gives you `allCases`, an array of every case.")
        ]
    )

    // ── Lesson 14 ──────────────────────────────────────────────
    static let l14 = Lesson(
        id: 14,
        title: "Closures",
        subtitle: "Functions as values — the heart of Swift",
        emoji: "🔒",
        difficulty: .intermediate,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "Closure Syntax",
                body: "A closure is a self-contained block of code you can store in a variable or pass to a function. The full syntax: `{ (params) -> ReturnType in body }`.",
                codeExample: """
// Store a closure in a variable
let greet = { (name: String) -> String in
    "Hello, \\(name)!"
}
print(greet("Jeremy"))  // Hello, Jeremy!

// A function that takes a closure
func run(_ action: () -> Void) {
    print("Before")
    action()
    print("After")
}
run { print("Running!") }
"""
            ),
            ContentSection(
                heading: "Trailing Closures & Shorthand",
                body: "When a closure is the last argument, move it outside the parentheses. Swift can also infer types and lets you use shorthand names `$0`, `$1`, `$2` for arguments.",
                codeExample: """
let numbers = [3, 1, 4, 1, 5]

// Full syntax
let sorted1 = numbers.sorted(by: { (a: Int, b: Int) -> Bool in a < b })

// Trailing closure with inferred types
let sorted2 = numbers.sorted { a, b in a < b }

// Shorthand argument names
let sorted3 = numbers.sorted { $0 < $1 }

// Operator shorthand (shortest possible!)
let sorted4 = numbers.sorted(by: <)
"""
            ),
            ContentSection(
                heading: "Closures with map, filter, reduce",
                body: "Closures power Swift's functional-style collection methods. Combine them to transform data elegantly.",
                codeExample: """
let scores = [45, 92, 78, 61, 88]

// map: transform every element
let doubled = scores.map { $0 * 2 }
// [90, 184, 156, 122, 176]

// filter: keep only matching elements
let passing = scores.filter { $0 >= 60 }
// [92, 78, 61, 88]

// reduce: combine into one value
let total = scores.reduce(0) { $0 + $1 }
// 364 (or: scores.reduce(0, +))

// Chain them together!
let result = scores
    .filter { $0 >= 60 }
    .map { "Score: \\($0)" }
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What is a closure?",
                         options: ["A type of class", "A self-contained block of code that can be passed around", "A special loop", "A Swift keyword"],
                         correctIndex: 1, explanation: "Closures are anonymous functions that can be stored in variables and passed to other functions."),
            QuizQuestion(question: "What does `$0` mean inside a closure?",
                         options: ["The return value", "The first argument shorthand", "A global variable", "The closure itself"],
                         correctIndex: 1, explanation: "`$0` is shorthand for the first argument, `$1` for the second, etc."),
            QuizQuestion(question: "What does `map` do?",
                         options: ["Finds elements", "Transforms each element into something new", "Removes elements", "Counts elements"],
                         correctIndex: 1, explanation: "`map` applies a closure to every element and returns a new array of the transformed values.")
        ]
    )

    // =========================================================
    // MARK: - SECTION 3: Object-Oriented Swift
    // =========================================================

    static let section3 = LessonSection(
        id: 3,
        title: "Object-Oriented Swift",
        emoji: "🏛️",
        description: "Inheritance, initializers, properties, methods, access control, and extensions.",
        lessons: [l15, l16, l17, l18, l19, l20]
    )

    // ── Lesson 15 ──────────────────────────────────────────────
    static let l15 = Lesson(
        id: 15,
        title: "Inheritance",
        subtitle: "Build new classes from existing ones",
        emoji: "🧬",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Subclassing",
                body: "A subclass inherits all properties and methods of its superclass. Use `:` to subclass. Call the parent's initializer with `super.init()`.",
                codeExample: """
class Animal {
    var name: String
    init(name: String) { self.name = name }
    func speak() { print("...") }
}

class Dog: Animal {
    var breed: String
    init(name: String, breed: String) {
        self.breed = breed
        super.init(name: name)  // must call super
    }
}

let d = Dog(name: "Rex", breed: "Labrador")
print(d.name)   // Rex (inherited)
"""
            ),
            ContentSection(
                heading: "Overriding Methods & Properties",
                body: "Use `override` to replace a superclass method with a custom version. Call `super.method()` to also run the parent's version.",
                codeExample: """
class Dog: Animal {
    var breed: String
    init(name: String, breed: String) {
        self.breed = breed
        super.init(name: name)
    }

    override func speak() {
        print("\\(name) says: Woof!")
    }
}

let d = Dog(name: "Buddy", breed: "Poodle")
d.speak()  // Buddy says: Woof!
"""
            ),
            ContentSection(
                heading: "Polymorphism & final",
                body: "A superclass variable can hold a subclass instance. `final` prevents a class or method from being subclassed or overridden.",
                codeExample: """
class Cat: Animal {
    override func speak() { print("\\(name) says: Meow!") }
}

let animals: [Animal] = [Dog(name: "Rex", breed: "Lab"), Cat(name: "Milo")]
for animal in animals {
    animal.speak()  // calls each subclass version!
}
// Rex says: Woof!
// Milo says: Meow!

// Prevent further subclassing
final class Singleton { }
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What syntax creates a subclass?",
                         options: ["class Sub extends Super", "class Sub: Super", "class Sub inherits Super", "sub class Sub of Super"],
                         correctIndex: 1, explanation: "Swift uses `class SubclassName: SuperclassName { }`."),
            QuizQuestion(question: "What keyword is required to override a method?",
                         options: ["super", "override", "virtual", "replace"], correctIndex: 1,
                         explanation: "You must write `override` before any method that replaces a superclass method."),
            QuizQuestion(question: "What does `final` do?",
                         options: ["Makes a class abstract", "Prevents subclassing or overriding", "Forces override", "Marks as deprecated"],
                         correctIndex: 1, explanation: "`final` prevents a class from being subclassed, or a method from being overridden.")
        ]
    )

    // ── Lesson 16 ──────────────────────────────────────────────
    static let l16 = Lesson(
        id: 16,
        title: "Initialization",
        subtitle: "How Swift sets up instances",
        emoji: "🏁",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Designated & Convenience Initializers",
                body: "A designated initializer fully sets up the object. A convenience initializer calls another initializer to simplify object creation.",
                codeExample: """
class Coffee {
    let name: String
    let shots: Int
    let hasMilk: Bool

    // Designated
    init(name: String, shots: Int, hasMilk: Bool) {
        self.name = name
        self.shots = shots
        self.hasMilk = hasMilk
    }

    // Convenience – shortcut for an espresso
    convenience init(espresso: String) {
        self.init(name: espresso, shots: 1, hasMilk: false)
    }
}

let c = Coffee(espresso: "Ristretto")
"""
            ),
            ContentSection(
                heading: "Failable Initializers",
                body: "A failable initializer `init?` returns an Optional. If the input is invalid, return `nil` to signal failure.",
                codeExample: """
struct Temperature {
    let celsius: Double

    init?(celsius: Double) {
        guard celsius >= -273.15 else { return nil }
        self.celsius = celsius
    }
}

let valid   = Temperature(celsius: 100)  // Optional(...)
let invalid = Temperature(celsius: -300) // nil
"""
            ),
            ContentSection(
                heading: "Struct Memberwise Init & deinit",
                body: "Structs get a free memberwise initializer if you don't define your own. Classes get a `deinit` that runs just before the instance is destroyed.",
                codeExample: """
// Struct: free memberwise init
struct Point { var x: Double; var y: Double }
let p = Point(x: 1, y: 2)  // auto-generated!

// Class: deinit
class FileHandle {
    let path: String
    init(path: String) { self.path = path }
    deinit { print("Closed: \\(path)") }
}

// When the instance is deallocated, deinit runs.
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What is a convenience initializer?",
                         options: ["The only initializer in a struct", "A shortcut init that calls another init", "An init that can fail", "An init defined in an extension"],
                         correctIndex: 1, explanation: "`convenience init` provides a simpler way to create an instance by delegating to a designated init."),
            QuizQuestion(question: "What does `init?` return?",
                         options: ["A forced value", "An optional instance (nil on failure)", "A throwing function", "A Bool"],
                         correctIndex: 1, explanation: "A failable initializer returns an Optional — `nil` if the init fails."),
            QuizQuestion(question: "When is `deinit` called?",
                         options: ["When the object is created", "When the object is deallocated", "After every method call", "When the app launches"],
                         correctIndex: 1, explanation: "`deinit` runs just before an instance is destroyed and its memory freed.")
        ]
    )

    // ── Lesson 17 ──────────────────────────────────────────────
    static let l17 = Lesson(
        id: 17,
        title: "Properties Deep Dive",
        subtitle: "Stored, computed, lazy & observers",
        emoji: "📊",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Computed Properties",
                body: "A computed property calculates its value on demand — it doesn't store data itself. Read-only ones only need a `get` block (or just a body).",
                codeExample: """
struct Rectangle {
    var width: Double
    var height: Double

    // Read-write computed property
    var area: Double {
        get { width * height }
        set { width = newValue / height }
    }

    // Read-only shorthand
    var perimeter: Double { 2 * (width + height) }
}

var r = Rectangle(width: 5, height: 3)
print(r.area)       // 15.0
r.area = 30         // sets width to 10
"""
            ),
            ContentSection(
                heading: "Property Observers",
                body: "`willSet` runs just before a property changes (new value is `newValue`). `didSet` runs just after it changes (old value is `oldValue`).",
                codeExample: """
class StepCounter {
    var steps: Int = 0 {
        willSet { print("About to change to \\(newValue)") }
        didSet  { print("Changed from \\(oldValue) to \\(steps)") }
    }
}

let counter = StepCounter()
counter.steps = 100
// About to change to 100
// Changed from 0 to 100
"""
            ),
            ContentSection(
                heading: "Lazy & Static Properties",
                body: "A `lazy` property is only computed the first time it's accessed — great for expensive operations. `static` properties belong to the type itself, not any instance.",
                codeExample: """
class DataLoader {
    lazy var data: [String] = {
        print("Loading…")
        return ["Row1", "Row2", "Row3"]
    }()
}

let loader = DataLoader()
// "Loading…" not printed yet
print(loader.data[0])  // now it loads!

// Static
struct AppConfig {
    static let version = "1.0.0"
    static var debug = false
}
print(AppConfig.version)  // "1.0.0"
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What is a computed property?",
                         options: ["A property set once at init", "A property that calculates its value each time it's accessed", "A property that can only be read", "A static property"],
                         correctIndex: 1, explanation: "Computed properties run code to derive a value — they don't store anything."),
            QuizQuestion(question: "When does `willSet` fire?",
                         options: ["After the property changes", "Before the property changes", "When the object is created", "When the object is destroyed"],
                         correctIndex: 1, explanation: "`willSet` is called just before the new value is stored."),
            QuizQuestion(question: "What is a `lazy` property?",
                         options: ["Computed on every access", "Initialized only when first accessed", "A constant", "A class-level property"],
                         correctIndex: 1, explanation: "`lazy var` defers initialization until the first time the property is used.")
        ]
    )

    // ── Lesson 18 ──────────────────────────────────────────────
    static let l18 = Lesson(
        id: 18,
        title: "Methods & Subscripts",
        subtitle: "Instance methods, type methods, and custom subscripts",
        emoji: "🛠️",
        difficulty: .intermediate,
        estimatedMinutes: 8,
        sections: [
            ContentSection(
                heading: "Instance vs Type Methods",
                body: "Instance methods operate on a specific instance. Type methods (marked `static`) belong to the type itself and are called on the type, not an instance.",
                codeExample: """
struct Circle {
    var radius: Double

    // Instance method
    func area() -> Double { .pi * radius * radius }

    // Type method
    static func unitCircle() -> Circle {
        Circle(radius: 1.0)
    }
}

let c = Circle(radius: 5)
print(c.area())              // 78.54...
let unit = Circle.unitCircle()
"""
            ),
            ContentSection(
                heading: "Mutating Methods in Structs",
                body: "Structs are value types — to modify `self` inside a method, mark it `mutating`. Classes don't need this.",
                codeExample: """
struct Counter {
    var count = 0

    mutating func increment() { count += 1 }
    mutating func reset()     { count = 0 }
}

var c = Counter()
c.increment()
c.increment()
print(c.count)  // 2
c.reset()
print(c.count)  // 0
"""
            ),
            ContentSection(
                heading: "Subscripts",
                body: "Subscripts let you access members of a collection, list, or sequence using bracket syntax. You can define your own.",
                codeExample: """
struct Matrix {
    let rows: Int, cols: Int
    var grid: [Double]

    init(rows: Int, cols: Int) {
        self.rows = rows; self.cols = cols
        grid = Array(repeating: 0.0, count: rows * cols)
    }

    subscript(row: Int, col: Int) -> Double {
        get { grid[row * cols + col] }
        set { grid[row * cols + col] = newValue }
    }
}

var m = Matrix(rows: 2, cols: 2)
m[0, 1] = 3.5
print(m[0, 1])  // 3.5
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "How do you call a type method?",
                         options: ["instance.method()", "Type.method()", "self.static.method()", "static method()"],
                         correctIndex: 1, explanation: "Type methods are called on the type itself: `Circle.unitCircle()`."),
            QuizQuestion(question: "Why do struct methods need `mutating`?",
                         options: ["All methods need it", "Structs are value types; `mutating` allows modifying self", "It makes them faster", "It prevents overriding"],
                         correctIndex: 1, explanation: "Structs are value types and immutable by default. `mutating` opts into modifying `self`."),
            QuizQuestion(question: "What does a subscript enable?",
                         options: ["Inheritance", "Bracket syntax for accessing values", "Optional chaining", "Error handling"],
                         correctIndex: 1, explanation: "Subscripts let you use `obj[index]` syntax for custom types.")
        ]
    )

    // ── Lesson 19 ──────────────────────────────────────────────
    static let l19 = Lesson(
        id: 19,
        title: "Access Control",
        subtitle: "Control who can see and change your code",
        emoji: "🔐",
        difficulty: .intermediate,
        estimatedMinutes: 7,
        sections: [
            ContentSection(
                heading: "The Five Access Levels",
                body: "Swift has five access levels, from most to least restrictive: `private`, `fileprivate`, `internal` (default), `public`, `open`.",
                codeExample: """
// open       – subclass/override from any module
// public     – use from any module, no override
// internal   – use within same module (DEFAULT)
// fileprivate– use within same .swift file
// private    – use within same declaration block

public class APIClient {
    public var baseURL: String      // usable everywhere
    internal var session: URLSession // module only
    private var apiKey: String       // this class only

    public init(url: String, key: String) {
        baseURL = url; apiKey = key
        session = URLSession.shared
    }
}
"""
            ),
            ContentSection(
                heading: "private vs fileprivate",
                body: "`private` restricts to the same type/extension. `fileprivate` allows access to anything in the same Swift file.",
                codeExample: """
// In the same file:
struct A {
    private var secret = "hidden"
    fileprivate var visible = "file-wide"
}

struct B {
    func test() {
        let a = A()
        // print(a.secret)   ❌ private
        print(a.visible)    // ✅ fileprivate – same file
    }
}
"""
            ),
            ContentSection(
                heading: "private(set)",
                body: "`private(set)` makes a property readable from outside but only writable from within the type — perfect for read-only public state.",
                codeExample: """
class BankAccount {
    private(set) var balance: Double = 0.0

    func deposit(_ amount: Double) {
        balance += amount  // ✅ can write internally
    }
}

let account = BankAccount()
account.deposit(100)
print(account.balance)     // ✅ can read externally
// account.balance = 9999  ❌ cannot write externally
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What is the default access level in Swift?",
                         options: ["private", "fileprivate", "internal", "public"],
                         correctIndex: 2, explanation: "`internal` is the default — accessible anywhere within the same module."),
            QuizQuestion(question: "What does `private` restrict access to?",
                         options: ["The same module", "The same file", "The same type/extension block", "Nothing — it's visible everywhere"],
                         correctIndex: 2, explanation: "`private` is the most restrictive level, limiting access to the enclosing type and its extensions in the same file."),
            QuizQuestion(question: "What does `private(set)` mean?",
                         options: ["Both read and write are private", "Read is public, write is private", "Read is private, write is public", "The property cannot be set at all"],
                         correctIndex: 1, explanation: "`private(set)` means the property is externally readable but can only be written from within the type.")
        ]
    )

    // ── Lesson 20 ──────────────────────────────────────────────
    static let l20 = Lesson(
        id: 20,
        title: "Extensions",
        subtitle: "Add functionality to any existing type",
        emoji: "🔌",
        difficulty: .intermediate,
        estimatedMinutes: 8,
        sections: [
            ContentSection(
                heading: "Extending Types You Don't Own",
                body: "Extensions add new methods, computed properties, and subscripts to any type — even types you didn't write, like `Int`, `String`, or `Array`.",
                codeExample: """
extension Int {
    var isEven: Bool { self % 2 == 0 }
    var squared: Int { self * self }

    func times(_ action: () -> Void) {
        for _ in 0..<self { action() }
    }
}

print(6.isEven)   // true
print(5.squared)  // 25
3.times { print("Hello!") }  // prints 3 times
"""
            ),
            ContentSection(
                heading: "Extending Strings & Arrays",
                body: "Add domain-specific helpers directly to built-in types. Keep them focused and clear.",
                codeExample: """
extension String {
    var isPalindrome: Bool {
        let clean = lowercased().filter { $0.isLetter }
        return clean == String(clean.reversed())
    }
    var wordCount: Int {
        split(separator: " ").count
    }
}

print("racecar".isPalindrome)  // true
print("Hello World".wordCount) // 2

extension Array where Element: Numeric {
    var sum: Element { reduce(0, +) }
}
print([1, 2, 3, 4].sum)  // 10
"""
            ),
            ContentSection(
                heading: "Protocol Conformance in Extensions",
                body: "Use an extension to make a type conform to a protocol. This keeps conformances organised and separate from the type's core definition.",
                codeExample: """
struct Person {
    let name: String
    let age: Int
}

// Add Equatable conformance in an extension
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name && lhs.age == rhs.age
    }
}

// Add CustomStringConvertible
extension Person: CustomStringConvertible {
    var description: String { "\\(name), age \\(age)" }
}

let p = Person(name: "Alex", age: 30)
print(p)  // Alex, age 30
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "Can you add stored properties in an extension?",
                         options: ["Yes, any property", "No, only computed properties", "Yes, but only var", "Only if the type is a class"],
                         correctIndex: 1, explanation: "Extensions can add computed properties and methods, but NOT stored properties."),
            QuizQuestion(question: "Can you extend types you don't own (like Int or String)?",
                         options: ["No, only your own types", "Yes, any type", "Only final types", "Only protocols"],
                         correctIndex: 1, explanation: "You can extend any type in Swift, including standard library types like Int and String."),
            QuizQuestion(question: "What is a benefit of adding protocol conformance in an extension?",
                         options: ["It's faster", "It keeps conformances organised and separate", "It allows stored properties", "It makes the type final"],
                         correctIndex: 1, explanation: "Separating protocol conformances into extensions keeps code organised and readable.")
        ]
    )

    // =========================================================
    // MARK: - SECTION 4: Protocol-Oriented Programming
    // =========================================================

    static let section4 = LessonSection(
        id: 4,
        title: "Protocol-Oriented Programming",
        emoji: "📋",
        description: "Protocols, default implementations, generics, and error handling.",
        lessons: [l21, l22, l23, l24]
    )

    // ── Lesson 21 ──────────────────────────────────────────────
    static let l21 = Lesson(
        id: 21,
        title: "Protocols",
        subtitle: "Define contracts any type can adopt",
        emoji: "📜",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Defining & Conforming to Protocols",
                body: "A protocol defines a blueprint of requirements. Any `struct`, `class`, or `enum` can conform by implementing all requirements.",
                codeExample: """
protocol Greetable {
    var name: String { get }
    func greet() -> String
}

struct Person: Greetable {
    var name: String
    func greet() -> String { "Hi, I'm \\(name)!" }
}

class Robot: Greetable {
    var name: String
    init(name: String) { self.name = name }
    func greet() -> String { "Beep boop. I am \\(name)." }
}

// Use protocol as a type
func introduceAll(_ items: [any Greetable]) {
    items.forEach { print($0.greet()) }
}
"""
            ),
            ContentSection(
                heading: "Protocol Property Requirements",
                body: "Protocol properties specify whether they need to be gettable, settable, or both. The conforming type can use `var` or `let` as appropriate.",
                codeExample: """
protocol Vehicle {
    var numberOfWheels: Int { get }      // at least readable
    var currentSpeed: Double { get set } // must be read-write
    func describe() -> String
}

struct Bicycle: Vehicle {
    let numberOfWheels = 2           // let is fine for get-only
    var currentSpeed: Double = 0.0

    func describe() -> String {
        "Bicycle going \\(currentSpeed) km/h"
    }
}
"""
            ),
            ContentSection(
                heading: "Common Swift Protocols",
                body: "Swift's standard library uses protocols extensively. Here are the ones you'll encounter most.",
                codeExample: """
// Equatable – compare with ==
struct Point: Equatable { var x, y: Double }
Point(x:1,y:2) == Point(x:1,y:2)  // true

// Comparable – compare with <, >, etc.
struct Student: Comparable {
    var gpa: Double
    static func < (lhs: Student, rhs: Student) -> Bool {
        lhs.gpa < rhs.gpa
    }
}

// Hashable – use in Sets and Dict keys
struct ID: Hashable { var value: Int }

// Codable = Encodable + Decodable (JSON!)
struct User: Codable { var name: String; var age: Int }

// CustomStringConvertible – custom print output
struct Color: CustomStringConvertible {
    var description: String { "RGB(...)" }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What is a protocol?",
                         options: ["A subclass", "A blueprint of requirements any type can conform to", "A global variable", "A type of closure"],
                         correctIndex: 1, explanation: "A protocol defines what a conforming type must implement, without specifying how."),
            QuizQuestion(question: "What keyword makes a type conform to a protocol?",
                         options: ["implements", "extends", ": ProtocolName after the type name", "conforms to"],
                         correctIndex: 2, explanation: "You list protocols after the type name with `:`, e.g. `struct Foo: Printable { }`."),
            QuizQuestion(question: "What does `Codable` enable?",
                         options: ["Inheritance", "Comparison with ==", "Encoding/decoding to JSON and other formats", "Iteration over cases"],
                         correctIndex: 2, explanation: "`Codable` is a typealias for `Encodable & Decodable`, letting you convert to/from JSON easily.")
        ]
    )

    // ── Lesson 22 ──────────────────────────────────────────────
    static let l22 = Lesson(
        id: 22,
        title: "Protocol Extensions",
        subtitle: "Default implementations & protocol composition",
        emoji: "🧩",
        difficulty: .intermediate,
        estimatedMinutes: 8,
        sections: [
            ContentSection(
                heading: "Default Implementations",
                body: "Extend a protocol to provide default implementations. Conforming types use the default unless they provide their own.",
                codeExample: """
protocol Describable {
    var name: String { get }
    func describe() -> String
}

// Default implementation
extension Describable {
    func describe() -> String {
        "I am \\(name)"
    }
}

struct Cat: Describable { var name: String }
struct Dog: Describable {
    var name: String
    func describe() -> String { "Woof, I'm \\(name)!" }
}

print(Cat(name: "Milo").describe())  // I am Milo (default)
print(Dog(name: "Rex").describe())   // Woof, I'm Rex! (custom)
"""
            ),
            ContentSection(
                heading: "Protocol Composition",
                body: "Require a type to conform to multiple protocols simultaneously using `&`. This is more flexible than inheritance.",
                codeExample: """
protocol Printable  { func printInfo() }
protocol Saveable   { func save() }

// This function requires BOTH
func process(_ item: Printable & Saveable) {
    item.printInfo()
    item.save()
}

struct Document: Printable, Saveable {
    var title: String
    func printInfo() { print("Doc: \\(title)") }
    func save()      { print("Saving \\(title)...") }
}

process(Document(title: "Report"))
"""
            ),
            ContentSection(
                heading: "Why Protocols Beat Inheritance for Structs",
                body: "Structs can't inherit, but they CAN conform to protocols. This is \"protocol-oriented programming\" — Apple's recommended Swift style.",
                codeExample: """
// ❌ Structs cannot inherit
// struct Dog: Animal { }  // ERROR

// ✅ Structs CAN conform to protocols
protocol Flyable  { func fly()  }
protocol Swimmable { func swim() }

struct Duck: Flyable, Swimmable {
    func fly()  { print("Flap flap!") }
    func swim() { print("Splash splash!") }
}

// Mix & match behaviours freely
struct Fish: Swimmable {
    func swim() { print("Glug glug!") }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does a protocol extension provide?",
                         options: ["Stored properties", "Default method implementations", "Inheritance", "Required initializers"],
                         correctIndex: 1, explanation: "Protocol extensions add default implementations that conforming types use if they don't provide their own."),
            QuizQuestion(question: "What is protocol composition syntax?",
                         options: ["Protocol1, Protocol2", "Protocol1 + Protocol2", "Protocol1 & Protocol2", "Protocol1 | Protocol2"],
                         correctIndex: 2, explanation: "`Printable & Saveable` means a type must conform to both protocols."),
            QuizQuestion(question: "Can structs use protocol-oriented programming?",
                         options: ["No, only classes", "Yes, by conforming to protocols", "Only with extensions", "Only for Equatable"],
                         correctIndex: 1, explanation: "Structs can't inherit, but they can conform to any number of protocols — making protocols more flexible.")
        ]
    )

    // ── Lesson 23 ──────────────────────────────────────────────
    static let l23 = Lesson(
        id: 23,
        title: "Generics",
        subtitle: "Write code that works with any type",
        emoji: "🧬",
        difficulty: .advanced,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "Generic Functions",
                body: "Use a type parameter `<T>` to write functions that work with any type. The actual type is determined at the call site.",
                codeExample: """
// Non-generic: need one for every type
func swapInts(_ a: inout Int, _ b: inout Int) { ... }

// Generic: works with ANY type
func swap<T>(_ a: inout T, _ b: inout T) {
    let temp = a; a = b; b = temp
}

var x = 5, y = 10
swap(&x, &y)
print(x, y)  // 10, 5

var s1 = "Hello", s2 = "World"
swap(&s1, &s2)
print(s1, s2)  // World, Hello
"""
            ),
            ContentSection(
                heading: "Generic Types",
                body: "Structs, classes, and enums can be generic too. A classic example is a typed Stack.",
                codeExample: """
struct Stack<Element> {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        items.popLast()
    }

    var top: Element? { items.last }
    var isEmpty: Bool { items.isEmpty }
}

var intStack = Stack<Int>()
intStack.push(1); intStack.push(2)
print(intStack.pop()!)  // 2

var strStack = Stack<String>()
strStack.push("Swift")
"""
            ),
            ContentSection(
                heading: "Type Constraints",
                body: "Restrict what types can be used with `where T: Protocol`. This lets you call protocol methods on `T` inside the function.",
                codeExample: """
// T must be Comparable
func findMax<T: Comparable>(_ array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    return array.max()
}

print(findMax([3, 1, 4, 1, 5])!)  // 5
print(findMax(["cat", "apple", "zebra"])!)  // zebra

// Multiple constraints
func merge<T: Comparable & Hashable>(_ a: [T], _ b: [T]) -> [T] {
    Array(Set(a + b)).sorted()
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does `<T>` in a generic function mean?",
                         options: ["T is always an Int", "T is a placeholder for any type determined at call site", "T must be a class", "T is a template literal"],
                         correctIndex: 1, explanation: "`T` is a type parameter. When you call the function, Swift substitutes the actual type."),
            QuizQuestion(question: "What are type constraints?",
                         options: ["Limits on variable names", "Requirements on what protocols T must conform to", "Limits on memory usage", "Required default values"],
                         correctIndex: 1, explanation: "Type constraints like `<T: Comparable>` ensure `T` has specific capabilities you can call inside the function."),
            QuizQuestion(question: "What is the benefit of generics over using `Any`?",
                         options: ["Generics are slower", "Generics provide type safety at compile time", "Generics use more memory", "There is no difference"],
                         correctIndex: 1, explanation: "Generics are type-safe — the compiler enforces correct usage. `Any` requires casting and can crash at runtime.")
        ]
    )

    // ── Lesson 24 ──────────────────────────────────────────────
    static let l24 = Lesson(
        id: 24,
        title: "Error Handling",
        subtitle: "throw, do-catch, and the Result type",
        emoji: "🚨",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Defining & Throwing Errors",
                body: "Create errors by making an enum conform to `Error`. Mark a function with `throws` if it can fail, then use `throw` to raise an error.",
                codeExample: """
enum LoginError: Error {
    case wrongPassword
    case userNotFound
    case accountLocked(minutesLeft: Int)
}

func login(username: String, password: String) throws -> String {
    guard username == "admin" else { throw LoginError.userNotFound }
    guard password == "1234" else { throw LoginError.wrongPassword }
    return "Welcome, \\(username)!"
}
"""
            ),
            ContentSection(
                heading: "do-catch & try",
                body: "Call throwing functions with `try` inside a `do` block. Catch specific errors with `catch`, or catch all with a bare `catch`.",
                codeExample: """
do {
    let msg = try login(username: "admin", password: "wrong")
    print(msg)
} catch LoginError.wrongPassword {
    print("Bad password!")
} catch LoginError.userNotFound {
    print("User doesn't exist.")
} catch LoginError.accountLocked(let mins) {
    print("Locked for \\(mins) minutes.")
} catch {
    print("Unknown error: \\(error)")
}
"""
            ),
            ContentSection(
                heading: "try? and try! and Result",
                body: "`try?` converts a throwing call into an Optional — nil on error. `try!` crashes on error (use rarely). `Result<T, E>` is an enum you can return and inspect later.",
                codeExample: """
// try? – returns nil if throws
let result = try? login(username: "x", password: "y")
print(result ?? "Failed")  // "Failed"

// Result type
func loginResult(user: String, pass: String) -> Result<String, LoginError> {
    do {
        let msg = try login(username: user, password: pass)
        return .success(msg)
    } catch let e as LoginError {
        return .failure(e)
    } catch { return .failure(.userNotFound) }
}

switch loginResult(user: "admin", pass: "1234") {
case .success(let msg): print(msg)
case .failure(let err): print("Error: \\(err)")
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What keyword marks a function that can throw errors?",
                         options: ["throws", "throw", "catch", "error"], correctIndex: 0,
                         explanation: "`throws` in the function signature tells callers this function can fail."),
            QuizQuestion(question: "What does `try?` do?",
                         options: ["Crashes if error occurs", "Returns nil if error, Optional value if success", "Must be used in do-catch", "Ignores all errors"],
                         correctIndex: 1, explanation: "`try?` converts a throwing call into an Optional — nil if it throws, otherwise the wrapped value."),
            QuizQuestion(question: "What are the two cases of the `Result` type?",
                         options: [".true and .false", ".success and .failure", ".ok and .err", ".some and .none"],
                         correctIndex: 1, explanation: "`Result<T, E>` has `.success(T)` and `.failure(E)` cases.")
        ]
    )

    // =========================================================
    // MARK: - SECTION 5: Advanced Swift
    // =========================================================

    static let section5 = LessonSection(
        id: 5,
        title: "Advanced Swift",
        emoji: "🚀",
        description: "Type casting, memory management, async/await, and higher-order functions.",
        lessons: [l25, l26, l27, l28]
    )

    // ── Lesson 25 ──────────────────────────────────────────────
    static let l25 = Lesson(
        id: 25,
        title: "Type Casting",
        subtitle: "is, as?, as! and Any",
        emoji: "🎭",
        difficulty: .intermediate,
        estimatedMinutes: 7,
        sections: [
            ContentSection(
                heading: "Checking Types with `is`",
                body: "Use `is` to check whether an instance is of a certain type at runtime. It returns `true` or `false`.",
                codeExample: """
class Animal { }
class Dog: Animal { func bark() { print("Woof!") } }
class Cat: Animal { func meow() { print("Meow!") } }

let pets: [Animal] = [Dog(), Cat(), Dog()]

for pet in pets {
    if pet is Dog {
        print("It's a dog")
    } else if pet is Cat {
        print("It's a cat")
    }
}
"""
            ),
            ContentSection(
                heading: "Downcasting: as? and as!",
                body: "`as?` attempts a downcast and returns Optional (nil if it fails). `as!` force-downcasts and crashes if it fails — only use when you're 100% certain.",
                codeExample: """
for pet in pets {
    if let dog = pet as? Dog {
        dog.bark()  // safe downcast
    } else if let cat = pet as? Cat {
        cat.meow()
    }
}

// as! – use only when you're certain
let firstDog = pets[0] as! Dog
firstDog.bark()

// Upcasting (always safe)
let myDog = Dog()
let animal: Animal = myDog as Animal  // or just let animal: Animal = myDog
"""
            ),
            ContentSection(
                heading: "Any & AnyObject",
                body: "`Any` can hold any value at all (value types, reference types, functions). `AnyObject` holds only class instances. You need to cast before using the actual value.",
                codeExample: """
var mixed: [Any] = [1, "hello", 3.14, true, Dog()]

for item in mixed {
    switch item {
    case let n as Int:    print("Int: \\(n)")
    case let s as String: print("String: \\(s)")
    case let d as Double: print("Double: \\(d)")
    case let b as Bool:   print("Bool: \\(b)")
    default: print("Something else")
    }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does `is` do?",
                         options: ["Casts to a type", "Checks if an instance is of a certain type", "Unwraps an optional", "Compares two values"],
                         correctIndex: 1, explanation: "`is` is a type check operator that returns `true` or `false`."),
            QuizQuestion(question: "What does `as?` return?",
                         options: ["A forced value", "An Optional — nil if cast fails", "A thrown error", "A Bool"],
                         correctIndex: 1, explanation: "`as?` attempts the cast and returns `nil` if it fails, making it safe."),
            QuizQuestion(question: "What can `Any` hold?",
                         options: ["Only class instances", "Only value types", "Any type including closures", "Only Codable types"],
                         correctIndex: 2, explanation: "`Any` can hold values of any type — structs, classes, enums, even closures.")
        ]
    )

    // ── Lesson 26 ──────────────────────────────────────────────
    static let l26 = Lesson(
        id: 26,
        title: "Memory Management",
        subtitle: "ARC, weak references, and retain cycles",
        emoji: "🧠",
        difficulty: .advanced,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "ARC – Automatic Reference Counting",
                body: "Swift manages memory automatically using ARC. Every class instance has a reference count. When it hits zero, the memory is freed. You rarely need to think about this — but understanding it prevents bugs.",
                codeExample: """
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\\(name) created")
    }
    deinit { print("\\(name) destroyed") }
}

var p1: Person? = Person(name: "Alice")  // ref count: 1
var p2 = p1                              // ref count: 2
p1 = nil                                 // ref count: 1
p2 = nil                                 // ref count: 0 → deinit!
// Prints: Alice destroyed
"""
            ),
            ContentSection(
                heading: "weak & unowned References",
                body: "A `weak` reference doesn't increase the ref count and becomes `nil` when the object is deallocated. `unowned` also doesn't increase the count but assumes the object always exists (crashes if wrong).",
                codeExample: """
class Owner {
    var pet: Pet?
}

class Pet {
    weak var owner: Owner?  // weak — won't prevent dealloc
    let name: String
    init(name: String) { self.name = name }
}

var owner: Owner? = Owner()
var pet: Pet? = Pet(name: "Fluffy")
owner?.pet = pet
pet?.owner = owner

owner = nil  // Owner deallocates; pet.owner becomes nil safely
"""
            ),
            ContentSection(
                heading: "Retain Cycles & [weak self]",
                body: "A retain cycle occurs when two objects hold strong references to each other — neither can be freed. Closures can also cause cycles. Break them with `[weak self]`.",
                codeExample: """
class Timer {
    var callback: (() -> Void)?
    var count = 0

    // ❌ Retain cycle: Timer → callback → Timer (via self)
    func startBad() {
        callback = { self.count += 1 }  // strong capture
    }

    // ✅ Break cycle with [weak self]
    func startGood() {
        callback = { [weak self] in
            self?.count += 1  // self is now Optional
        }
    }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does ARC stand for?",
                         options: ["Automatic Release Control", "Automatic Reference Counting", "Advanced Runtime Core", "Asynchronous Reference Control"],
                         correctIndex: 1, explanation: "ARC stands for Automatic Reference Counting — Swift's memory management system."),
            QuizQuestion(question: "When does a `weak` reference become `nil`?",
                         options: ["When the app enters background", "When you assign nil to it manually", "When the referenced object is deallocated", "After every function call"],
                         correctIndex: 2, explanation: "`weak` references are automatically set to `nil` when the pointed-to object is deallocated."),
            QuizQuestion(question: "What causes a retain cycle?",
                         options: ["Using too many variables", "Two or more objects holding strong references to each other", "Using weak references", "Having too many classes"],
                         correctIndex: 1, explanation: "A retain cycle prevents deallocation: A holds B, B holds A, so neither ref count ever reaches zero.")
        ]
    )

    // ── Lesson 27 ──────────────────────────────────────────────
    static let l27 = Lesson(
        id: 27,
        title: "Concurrency",
        subtitle: "async/await — write async code like sync code",
        emoji: "⚡",
        difficulty: .advanced,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "The Problem & async/await",
                body: "Old-style async code used completion handlers (nested closures), leading to \"callback hell\". Swift's `async`/`await` makes async code read like synchronous code.",
                codeExample: """
// OLD WAY – callback hell 😱
func fetchUser(id: Int, completion: @escaping (String) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        completion("User #\\(id)")
    }
}

// NEW WAY – async/await ✅
func fetchUser(id: Int) async -> String {
    // Imagine a real network call here
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "User #\\(id)"
}
"""
            ),
            ContentSection(
                heading: "Calling async Functions",
                body: "Use `await` when calling an async function. Use `Task { }` to start async work from synchronous code (like a SwiftUI button action).",
                codeExample: """
// You MUST use await when calling async functions
async func loadData() async {
    let user = await fetchUser(id: 42)
    print(user)  // "User #42" – after the await resolves
}

// Start async work from sync context (SwiftUI, etc.)
Task {
    let user = await fetchUser(id: 1)
    print(user)
}

// Run two tasks concurrently with async let
async let user1 = fetchUser(id: 1)
async let user2 = fetchUser(id: 2)
let both = await [user1, user2]  // both run in parallel!
"""
            ),
            ContentSection(
                heading: "@MainActor — Updating the UI",
                body: "UI updates must happen on the main thread. Mark functions or whole types with `@MainActor` to guarantee they run on the main thread.",
                codeExample: """
class ViewModel: ObservableObject {
    @Published var message = "Loading…"

    func load() {
        Task {
            // Do work on background thread
            let data = await fetchUser(id: 1)

            // Update UI on main thread
            await MainActor.run {
                message = data
            }
        }
    }
}

// Or mark the whole class @MainActor
@MainActor
class SafeViewModel: ObservableObject {
    @Published var message = "Loading…"
    func load() async { message = await fetchUser(id: 1) }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does `async` mark in Swift?",
                         options: ["A variable that can change", "A function that can perform asynchronous work", "A thread-safe property", "A throwing function"],
                         correctIndex: 1, explanation: "`async` on a function means it can suspend and resume, allowing it to wait for async operations."),
            QuizQuestion(question: "What does `await` do?",
                         options: ["Starts a new thread", "Creates a Task", "Pauses execution until the async operation completes", "Throws an error"],
                         correctIndex: 2, explanation: "`await` suspends the current task until the awaited operation produces a result."),
            QuizQuestion(question: "What does `@MainActor` ensure?",
                         options: ["Code runs on a background thread", "Code runs on the main thread", "Code is thread-safe automatically", "Code never suspends"],
                         correctIndex: 1, explanation: "`@MainActor` guarantees execution on the main thread — required for UI updates in SwiftUI and UIKit.")
        ]
    )

    // ── Lesson 28 ──────────────────────────────────────────────
    static let l28 = Lesson(
        id: 28,
        title: "Higher-Order Functions",
        subtitle: "map, filter, reduce, flatMap & more",
        emoji: "🔄",
        difficulty: .intermediate,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "map & compactMap",
                body: "`map` transforms every element. `compactMap` transforms and removes nils — great for converting strings to numbers.",
                codeExample: """
let names = ["alice", "bob", "carol"]
let upper = names.map { $0.capitalized }
// ["Alice", "Bob", "Carol"]

let lengths = names.map(\\.count)
// [5, 3, 5]

// compactMap removes nil results
let strings = ["1", "two", "3", "four", "5"]
let numbers = strings.compactMap { Int($0) }
// [1, 3, 5]  (non-number strings become nil → removed)
"""
            ),
            ContentSection(
                heading: "filter & reduce",
                body: "`filter` keeps elements that match a condition. `reduce` folds all elements into a single value.",
                codeExample: """
let scores = [45, 72, 88, 91, 55, 63]

let passing = scores.filter { $0 >= 60 }
// [72, 88, 91, 63]

let total = scores.reduce(0, +)      // 414
let average = Double(total) / Double(scores.count) // 69.0

// reduce with a custom accumulator
let words = ["Swift", "is", "awesome"]
let sentence = words.reduce("") { acc, word in
    acc.isEmpty ? word : "\\(acc) \\(word)"
}
// "Swift is awesome"
"""
            ),
            ContentSection(
                heading: "flatMap, sorted & zip",
                body: "`flatMap` maps and then flattens. `sorted(by:)` lets you customise the order. `zip` pairs two sequences together.",
                codeExample: """
// flatMap
let nested = [[1,2,3],[4,5],[6]]
let flat = nested.flatMap { $0 }  // [1,2,3,4,5,6]

// Custom sort
let people = [("Alice", 30), ("Bob", 25), ("Carol", 35)]
let byAge = people.sorted { $0.1 < $1.1 }
// [("Bob",25),("Alice",30),("Carol",35)]

// zip
let letters = ["A","B","C"]
let numbers = [1, 2, 3]
for (letter, number) in zip(letters, numbers) {
    print("\\(letter): \\(number)")
}
// A: 1, B: 2, C: 3
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What does `map` return?",
                         options: ["The first matching element", "A new array with each element transformed", "A filtered array", "A single combined value"],
                         correctIndex: 1, explanation: "`map` applies a closure to every element and returns a new array of the results."),
            QuizQuestion(question: "What makes `compactMap` different from `map`?",
                         options: ["It's faster", "It works on Dictionaries", "It removes nil results from the output", "It sorts the results"],
                         correctIndex: 2, explanation: "`compactMap` maps and removes nils, so the result is always `[T]` not `[T?]`."),
            QuizQuestion(question: "What does `reduce` do?",
                         options: ["Removes elements", "Transforms elements", "Combines all elements into a single value", "Splits an array"],
                         correctIndex: 2, explanation: "`reduce` starts with an initial value and applies a closure to combine each element into one final result.")
        ]
    )

    // =========================================================
    // MARK: - SECTION 6: SwiftUI Fundamentals
    // =========================================================

    static let section6 = LessonSection(
        id: 6,
        title: "SwiftUI Fundamentals",
        emoji: "📱",
        description: "Build real iOS app UIs with SwiftUI views, state, navigation, and forms.",
        lessons: [l29, l30, l31, l32]
    )

    // ── Lesson 29 ──────────────────────────────────────────────
    static let l29 = Lesson(
        id: 29,
        title: "Your First SwiftUI Views",
        subtitle: "Text, Image, stacks, and modifiers",
        emoji: "🎨",
        difficulty: .beginner,
        estimatedMinutes: 9,
        sections: [
            ContentSection(
                heading: "Basic Views",
                body: "In SwiftUI every piece of UI is a `View`. The most common primitives are `Text`, `Image`, `Color`, `Divider`, and `Spacer`. Compose them to build complex UIs.",
                codeExample: """
import SwiftUI

struct MyView: View {
    var body: some View {
        Text("Hello, Swift!")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.blue)

        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.yellow)

        Color.green
            .frame(height: 4)
    }
}
"""
            ),
            ContentSection(
                heading: "Layout Stacks",
                body: "Use `VStack` (vertical), `HStack` (horizontal), and `ZStack` (layered/overlapping) to arrange views. Pass `alignment` and `spacing` to customise.",
                codeExample: """
VStack(alignment: .leading, spacing: 12) {
    Text("Title").font(.headline)
    Text("Subtitle").foregroundColor(.secondary)

    HStack {
        Image(systemName: "person.fill")
        Text("Profile")
        Spacer()  // pushes right
        Text("Edit").foregroundColor(.blue)
    }
}

ZStack {
    Color.blue.ignoresSafeArea()  // background
    Text("Overlay Text")
        .foregroundColor(.white)
        .font(.largeTitle)
}
"""
            ),
            ContentSection(
                heading: "View Modifiers",
                body: "Modifiers transform a view and return a new view. Chain as many as you need. Order matters — each modifier wraps the previous result.",
                codeExample: """
Text("Hello!")
    .font(.title)
    .bold()
    .italic()
    .foregroundColor(.white)
    .padding(20)
    .background(Color.blue)
    .cornerRadius(12)
    .shadow(radius: 5)

// frame modifier controls size
Rectangle()
    .fill(Color.orange)
    .frame(width: 100, height: 50)
    .padding()
    .border(Color.black, width: 2)
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What stack arranges views vertically?",
                         options: ["HStack", "ZStack", "VStack", "LinearStack"],
                         correctIndex: 2, explanation: "`VStack` lays views out vertically from top to bottom."),
            QuizQuestion(question: "What does `ZStack` do?",
                         options: ["Arranges views left to right", "Arranges views top to bottom", "Overlays views on top of each other", "Scrolls through views"],
                         correctIndex: 2, explanation: "`ZStack` layers views on top of each other along the z-axis (depth)."),
            QuizQuestion(question: "What does `.padding()` do?",
                         options: ["Adds a border", "Adds space inside the view", "Adds space around the view", "Changes the view's colour"],
                         correctIndex: 2, explanation: "`.padding()` adds space around the outside of a view — between it and neighbouring views.")
        ]
    )

    // ── Lesson 30 ──────────────────────────────────────────────
    static let l30 = Lesson(
        id: 30,
        title: "State & Data Flow",
        subtitle: "@State, @Binding, @StateObject & @Published",
        emoji: "🔗",
        difficulty: .intermediate,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "@State — Local View State",
                body: "`@State` stores mutable state inside a SwiftUI view. When the value changes, SwiftUI automatically re-renders the view. Always use `@State` for simple, view-local values.",
                codeExample: """
struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \\(count)")
                .font(.largeTitle)

            HStack {
                Button("−") { count -= 1 }
                    .buttonStyle(.bordered)
                Button("+") { count += 1 }
                    .buttonStyle(.bordered)
            }
        }
    }
}
"""
            ),
            ContentSection(
                heading: "@Binding — Share State with Child Views",
                body: "Pass a `@Binding` to a child view so it can read AND write the parent's `@State`. Use the `$` prefix to create a binding from a `@State` variable.",
                codeExample: """
// Child view receives a Binding
struct ToggleRow: View {
    let label: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(label, isOn: $isOn)
    }
}

// Parent view passes the binding with $
struct SettingsView: View {
    @State private var notificationsOn = true
    @State private var darkModeOn = false

    var body: some View {
        Form {
            ToggleRow(label: "Notifications", isOn: $notificationsOn)
            ToggleRow(label: "Dark Mode",    isOn: $darkModeOn)
        }
    }
}
"""
            ),
            ContentSection(
                heading: "@StateObject, @ObservedObject & @Published",
                body: "For more complex state, use `ObservableObject` classes. Mark properties with `@Published` to trigger UI updates. Use `@StateObject` for the owner and `@ObservedObject` for views that just observe.",
                codeExample: """
// The data model
class CartViewModel: ObservableObject {
    @Published var items: [String] = []
    @Published var total: Double = 0.0

    func addItem(_ name: String, price: Double) {
        items.append(name)
        total += price
    }
}

// The view
struct CartView: View {
    @StateObject private var cart = CartViewModel()

    var body: some View {
        VStack {
            List(cart.items, id: \\.self) { Text($0) }
            Text("Total: $\\(cart.total, specifier: \"%.2f\")")
            Button("Add Coffee") { cart.addItem("Coffee", price: 3.50) }
        }
    }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "When should you use `@State`?",
                         options: ["For data shared across many screens", "For local, simple, view-owned mutable state", "For network data only", "For constants"],
                         correctIndex: 1, explanation: "`@State` is for simple local state that only one view owns and mutates."),
            QuizQuestion(question: "What does the `$` prefix create?",
                         options: ["A copy of the value", "A Binding to the @State property", "A String representation", "An Optional"],
                         correctIndex: 1, explanation: "`$myVar` creates a `Binding<T>` from a `@State var`, allowing two-way data flow."),
            QuizQuestion(question: "What does `@Published` do?",
                         options: ["Makes a property public", "Triggers SwiftUI view updates when the property changes", "Persists to disk", "Makes it a constant"],
                         correctIndex: 1, explanation: "`@Published` publishes change notifications so SwiftUI views that observe the object are re-rendered.")
        ]
    )

    // ── Lesson 31 ──────────────────────────────────────────────
    static let l31 = Lesson(
        id: 31,
        title: "Navigation & Lists",
        subtitle: "NavigationStack, List, sheets & alerts",
        emoji: "🗺️",
        difficulty: .intermediate,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "NavigationStack & NavigationLink",
                body: "Wrap your root view in `NavigationStack` to enable push navigation. Use `NavigationLink` to push a new view when tapped.",
                codeExample: """
struct FruitListView: View {
    let fruits = ["Apple", "Banana", "Cherry", "Durian"]

    var body: some View {
        NavigationStack {
            List(fruits, id: \\.self) { fruit in
                NavigationLink(fruit) {
                    // Destination view
                    VStack {
                        Text(fruit).font(.largeTitle)
                        Text("Delicious!").foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Fruits")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
"""
            ),
            ContentSection(
                heading: "List with Custom Data & Sections",
                body: "`List` displays rows of data. Use `ForEach` with `Identifiable` models for full control. Add `Section` views to group rows.",
                codeExample: """
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool
}

struct TaskListView: View {
    @State private var tasks = [
        Task(title: "Learn Swift", isDone: true),
        Task(title: "Build an app", isDone: false)
    ]

    var body: some View {
        List {
            Section("To Do") {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                        Text(task.title)
                    }
                }
                .onDelete { tasks.remove(atOffsets: $0) }
            }
        }
    }
}
"""
            ),
            ContentSection(
                heading: "Sheets, Alerts & Confirmation Dialogs",
                body: "Present modal content with `.sheet()`. Show alerts with `.alert()`. Use `.confirmationDialog()` for destructive actions.",
                codeExample: """
struct ContentView: View {
    @State private var showSheet = false
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Show Sheet") { showSheet = true }
            Button("Show Alert") { showAlert = true }
        }
        .sheet(isPresented: $showSheet) {
            Text("I'm a modal sheet!")
                .presentationDetents([.medium, .large])
        }
        .alert("Are you sure?", isPresented: $showAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This cannot be undone.")
        }
    }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What container enables push navigation in SwiftUI?",
                         options: ["ScrollView", "NavigationView", "NavigationStack", "TabView"],
                         correctIndex: 2, explanation: "`NavigationStack` is the modern (iOS 16+) way to enable push-pop navigation."),
            QuizQuestion(question: "What modifier presents a sheet?",
                         options: [".modal()", ".present()", ".sheet(isPresented:)", ".popup()"],
                         correctIndex: 2, explanation: "`.sheet(isPresented: $bool)` presents a modal sheet when the Bool becomes true."),
            QuizQuestion(question: "What does `ForEach` need from its data?",
                         options: ["An Array only", "Identifiable items or explicit id keypath", "A Range", "A Dictionary"],
                         correctIndex: 1, explanation: "`ForEach` needs each item to be uniquely identifiable — either via `Identifiable` conformance or an `id:` keypath.")
        ]
    )

    // ── Lesson 32 ──────────────────────────────────────────────
    static let l32 = Lesson(
        id: 32,
        title: "Forms & User Input",
        subtitle: "TextField, Toggle, Slider, Picker & Form",
        emoji: "📋",
        difficulty: .intermediate,
        estimatedMinutes: 10,
        sections: [
            ContentSection(
                heading: "TextField & Button",
                body: "`TextField` binds to a `@State` String for text input. Buttons can be disabled with `.disabled()`. Use `@FocusState` to control keyboard focus.",
                codeExample: """
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusField: Field?

    enum Field { case username, password }

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .focused($focusField, equals: .username)
            SecureField("Password", text: $password)
                .focused($focusField, equals: .password)

            Button("Log In") {
                focusField = nil  // dismiss keyboard
                // perform login
            }
            .disabled(username.isEmpty || password.isEmpty)
            .buttonStyle(.borderedProminent)
        }
    }
}
"""
            ),
            ContentSection(
                heading: "Toggle, Slider & Stepper",
                body: "Use `Toggle` for on/off settings, `Slider` for a continuous range, and `Stepper` for step-by-step increments.",
                codeExample: """
struct SettingsView: View {
    @State private var notifications = true
    @State private var volume: Double = 0.5
    @State private var fontSize = 14

    var body: some View {
        Form {
            Section("Notifications") {
                Toggle("Push Notifications", isOn: $notifications)
            }
            Section("Audio") {
                Slider(value: $volume, in: 0...1) {
                    Text("Volume")
                } minimumValueLabel: {
                    Image(systemName: "speaker")
                } maximumValueLabel: {
                    Image(systemName: "speaker.3")
                }
            }
            Section("Appearance") {
                Stepper("Font Size: \\(fontSize)pt", value: $fontSize, in: 10...24)
            }
        }
    }
}
"""
            ),
            ContentSection(
                heading: "Picker & DatePicker",
                body: "`Picker` lets users choose from a list of options. `DatePicker` handles date and time selection. Wrap them in a `Form` for a native settings look.",
                codeExample: """
struct ProfileView: View {
    @State private var country = "USA"
    @State private var birthday = Date()
    @State private var theme = "System"

    let countries = ["USA", "UK", "Canada", "Australia"]
    let themes = ["Light", "Dark", "System"]

    var body: some View {
        Form {
            Section("Personal") {
                Picker("Country", selection: $country) {
                    ForEach(countries, id: \\.self) { Text($0) }
                }
                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
            }
            Section("Display") {
                Picker("Theme", selection: $theme) {
                    ForEach(themes, id: \\.self) { Text($0) }
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Profile")
    }
}
"""
            )
        ],
        quiz: [
            QuizQuestion(question: "What view is used for single-line text input?",
                         options: ["TextEditor", "TextField", "TextInput", "InputField"],
                         correctIndex: 1, explanation: "`TextField` provides a single-line text input field bound to a `String` via `@Binding`."),
            QuizQuestion(question: "How do you bind a Toggle to a Bool?",
                         options: ["Toggle(isOn: myBool)", "Toggle(\"Label\", isOn: $myBool)", "Toggle(\"Label\", value: myBool)", "Toggle.bind(myBool)"],
                         correctIndex: 1, explanation: "You pass a `Binding<Bool>` using `$myBool` — the `$` creates a two-way binding from `@State var myBool`."),
            QuizQuestion(question: "What container gives a native settings-style layout?",
                         options: ["VStack", "List", "Form", "ScrollView"],
                         correctIndex: 2, explanation: "`Form` renders its content in a grouped, native-looking settings style perfect for user preferences.")
        ]
    )
}
