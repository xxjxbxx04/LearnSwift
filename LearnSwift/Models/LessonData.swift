import Foundation

// MARK: - All Lessons Content

struct LessonData {
    static let all: [Lesson] = [

        // MARK: Lesson 1 – Variables & Constants
        Lesson(
            id: 1,
            title: "Variables & Constants",
            subtitle: "Store and manage values in Swift",
            emoji: "📦",
            difficulty: .beginner,
            estimatedMinutes: 5,
            sections: [
                ContentSection(
                    heading: "What is a Variable?",
                    body: "A variable is a named storage location that holds a value which can be changed later. In Swift you declare a variable using the `var` keyword.",
                    codeExample: """
var playerName = "Alex"
var score = 0
score = 10          // ✅ OK – var can change
playerName = "Sam"  // ✅ OK – var can change
"""
                ),
                ContentSection(
                    heading: "What is a Constant?",
                    body: "A constant holds a value that never changes after it is first set. Use `let` to declare a constant. Swift prefers constants – if a value won't change, always use `let`.",
                    codeExample: """
let maxLives = 3
let appName  = "LearnSwift"
// maxLives = 5  ❌ ERROR – cannot change a constant
"""
                ),
                ContentSection(
                    heading: "Type Inference",
                    body: "Swift is smart enough to figure out the type from the value you assign. You can also write the type explicitly with a colon.",
                    codeExample: """
var age = 25            // Swift infers Int
var price = 9.99        // Swift infers Double
var isHappy = true      // Swift infers Bool
var city: String = "New York"  // explicit type
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "Which keyword declares a value that CANNOT change?",
                    options: ["var", "let", "def", "val"],
                    correctIndex: 1,
                    explanation: "`let` creates a constant in Swift. Once set, its value cannot be changed."
                ),
                QuizQuestion(
                    question: "What will happen if you run: let x = 5; x = 10?",
                    options: [
                        "x becomes 10",
                        "x stays 5",
                        "A compile-time error occurs",
                        "A runtime error occurs"
                    ],
                    correctIndex: 2,
                    explanation: "Constants declared with `let` cannot be reassigned. Xcode will show a compile-time error."
                ),
                QuizQuestion(
                    question: "What type does Swift infer for: var temperature = 98.6?",
                    options: ["Int", "Float", "Double", "String"],
                    correctIndex: 2,
                    explanation: "Swift infers `Double` for decimal number literals by default."
                )
            ]
        ),

        // MARK: Lesson 2 – Data Types
        Lesson(
            id: 2,
            title: "Data Types",
            subtitle: "Understand Int, String, Bool, Double & more",
            emoji: "🔢",
            difficulty: .beginner,
            estimatedMinutes: 6,
            sections: [
                ContentSection(
                    heading: "Int – Whole Numbers",
                    body: "Use `Int` to store whole numbers (positive or negative). Perfect for counts, scores, and ages.",
                    codeExample: """
var lives: Int = 3
var temperature = -5    // Int
var distance = 1_000_000  // underscores improve readability
"""
                ),
                ContentSection(
                    heading: "Double – Decimal Numbers",
                    body: "`Double` stores numbers with a decimal point. It has more precision than `Float` and is the default for decimals in Swift.",
                    codeExample: """
var height: Double = 1.75
var pi = 3.14159
var bankBalance = 1234.56
"""
                ),
                ContentSection(
                    heading: "String – Text",
                    body: "Strings store text wrapped in double quotes. You can combine strings with `+` or use string interpolation with `\\(value)`.",
                    codeExample: """
var firstName = "Jeremy"
var greeting = "Hello, " + firstName  // concatenation
var message = "You scored \\(42) points!"  // interpolation
"""
                ),
                ContentSection(
                    heading: "Bool – True or False",
                    body: "A `Bool` can only be `true` or `false`. Great for flags and conditions.",
                    codeExample: """
var isLoggedIn: Bool = false
var hasWon = true
isLoggedIn = true   // now the user is logged in
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "Which type would you use to store someone's name?",
                    options: ["Int", "Bool", "String", "Double"],
                    correctIndex: 2,
                    explanation: "`String` is used for text values like names."
                ),
                QuizQuestion(
                    question: "What is the value of: var result = \"Score: \\(5 * 2)\"?",
                    options: ["Score: 5 * 2", "Score: 10", "Score: \\(10)", "Compile error"],
                    correctIndex: 1,
                    explanation: "String interpolation `\\(expression)` evaluates the expression and embeds the result."
                ),
                QuizQuestion(
                    question: "Which is the default decimal type in Swift?",
                    options: ["Float", "Double", "Decimal", "Number"],
                    correctIndex: 1,
                    explanation: "Swift defaults to `Double` for floating-point literals because it provides more precision."
                )
            ]
        ),

        // MARK: Lesson 3 – Control Flow
        Lesson(
            id: 3,
            title: "Control Flow",
            subtitle: "Make decisions with if, else & switch",
            emoji: "🔀",
            difficulty: .beginner,
            estimatedMinutes: 7,
            sections: [
                ContentSection(
                    heading: "if / else",
                    body: "An `if` statement runs a block of code only when a condition is `true`. Add `else` to handle the false case.",
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
                    body: "Use these operators to compare values inside conditions.",
                    codeExample: """
// ==  equal to
// !=  not equal to
// >   greater than
// <   less than
// >=  greater than or equal
// <=  less than or equal

var x = 10
print(x == 10)  // true
print(x > 15)   // false
"""
                ),
                ContentSection(
                    heading: "switch Statement",
                    body: "`switch` is cleaner than many `else if` chains. Each `case` must be exhaustive – use `default` to catch everything else.",
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
                QuizQuestion(
                    question: "What operator checks if two values are equal?",
                    options: ["=", "==", "!=", "=>"],
                    correctIndex: 1,
                    explanation: "`==` is the equality operator. A single `=` is assignment, not comparison."
                ),
                QuizQuestion(
                    question: "In a switch statement, what does `default` do?",
                    options: [
                        "It is always executed first",
                        "It runs when no case matches",
                        "It makes the switch optional",
                        "It stops the switch"
                    ],
                    correctIndex: 1,
                    explanation: "`default` matches anything that isn't covered by a specific `case`."
                ),
                QuizQuestion(
                    question: "What prints? if 5 > 3 { print(\"yes\") } else { print(\"no\") }",
                    options: ["no", "yes", "5", "3"],
                    correctIndex: 1,
                    explanation: "5 > 3 is true, so the first branch runs and prints \"yes\"."
                )
            ]
        ),

        // MARK: Lesson 4 – Loops
        Lesson(
            id: 4,
            title: "Loops",
            subtitle: "Repeat code with for and while",
            emoji: "🔁",
            difficulty: .beginner,
            estimatedMinutes: 7,
            sections: [
                ContentSection(
                    heading: "for-in Loop",
                    body: "A `for-in` loop iterates over a range or collection. The loop variable takes each value in turn.",
                    codeExample: """
// Range loop (1 through 5)
for i in 1...5 {
    print("Count: \\(i)")
}

// Half-open range (0, 1, 2 – not 3)
for i in 0..<3 {
    print(i)
}

// Looping an array
let fruits = ["Apple", "Banana", "Cherry"]
for fruit in fruits {
    print(fruit)
}
"""
                ),
                ContentSection(
                    heading: "while Loop",
                    body: "A `while` loop keeps running as long as its condition is `true`. Use it when you don't know in advance how many iterations you need.",
                    codeExample: """
var count = 0

while count < 5 {
    print("Tick \\(count)")
    count += 1
}
// Stops when count reaches 5
"""
                ),
                ContentSection(
                    heading: "break & continue",
                    body: "`break` exits the loop immediately. `continue` skips the rest of the current iteration and moves to the next.",
                    codeExample: """
for n in 1...10 {
    if n == 6 { break }      // stop at 6
    if n % 2 == 0 { continue } // skip even numbers
    print(n)  // prints 1, 3, 5
}
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "How many times does `for i in 1...4 { }` iterate?",
                    options: ["3", "4", "5", "0"],
                    correctIndex: 1,
                    explanation: "`1...4` is a closed range including 1, 2, 3, and 4 – that's 4 iterations."
                ),
                QuizQuestion(
                    question: "What does `continue` do inside a loop?",
                    options: [
                        "Exits the loop entirely",
                        "Skips to the next iteration",
                        "Restarts the loop from the beginning",
                        "Pauses the loop"
                    ],
                    correctIndex: 1,
                    explanation: "`continue` skips the remaining code in the current iteration and moves on to the next one."
                ),
                QuizQuestion(
                    question: "What range does `0..<5` represent?",
                    options: ["0 to 5 inclusive", "0 to 4 inclusive", "1 to 5 inclusive", "1 to 4 inclusive"],
                    correctIndex: 1,
                    explanation: "`..<` is a half-open range – it includes the lower bound (0) but excludes the upper bound (5), giving 0, 1, 2, 3, 4."
                )
            ]
        ),

        // MARK: Lesson 5 – Functions
        Lesson(
            id: 5,
            title: "Functions",
            subtitle: "Reusable blocks of code",
            emoji: "⚙️",
            difficulty: .beginner,
            estimatedMinutes: 8,
            sections: [
                ContentSection(
                    heading: "Defining a Function",
                    body: "Use the `func` keyword to define a function. Give it a name, optional parameters, and an optional return type.",
                    codeExample: """
func greet(name: String) {
    print("Hello, \\(name)!")
}

greet(name: "Jeremy")  // Hello, Jeremy!
"""
                ),
                ContentSection(
                    heading: "Return Values",
                    body: "Use `->` to specify a return type. The `return` keyword sends a value back to the caller.",
                    codeExample: """
func add(a: Int, b: Int) -> Int {
    return a + b
}

let result = add(a: 3, b: 4)  // result = 7
print(result)
"""
                ),
                ContentSection(
                    heading: "Argument Labels",
                    body: "Swift functions can have external argument labels (used when calling) and internal parameter names (used inside the function). Use `_` to omit the external label.",
                    codeExample: """
// External: "of", internal: "number"
func double(of number: Int) -> Int {
    return number * 2
}
let x = double(of: 5)  // reads like English!

// No external label
func square(_ n: Int) -> Int { n * n }
let y = square(4)  // no label needed
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "What keyword is used to define a function in Swift?",
                    options: ["def", "function", "func", "fn"],
                    correctIndex: 2,
                    explanation: "Swift uses the `func` keyword to declare functions."
                ),
                QuizQuestion(
                    question: "What symbol indicates a function's return type?",
                    options: ["=>", "->", ":", "::"],
                    correctIndex: 1,
                    explanation: "`->` is used to specify the return type, e.g. `func getName() -> String`."
                ),
                QuizQuestion(
                    question: "What does `_` mean as an argument label?",
                    options: [
                        "The parameter is optional",
                        "The parameter has no external label",
                        "The parameter is private",
                        "The parameter is unused"
                    ],
                    correctIndex: 1,
                    explanation: "Using `_` as an external label means callers don't write a label: `myFunc(42)` instead of `myFunc(value: 42)`."
                )
            ]
        ),

        // MARK: Lesson 6 – Arrays & Dictionaries
        Lesson(
            id: 6,
            title: "Arrays & Dictionaries",
            subtitle: "Store collections of values",
            emoji: "📚",
            difficulty: .beginner,
            estimatedMinutes: 8,
            sections: [
                ContentSection(
                    heading: "Arrays",
                    body: "An array stores an ordered list of values of the same type. Access items by their index (starting at 0).",
                    codeExample: """
var colors = ["Red", "Green", "Blue"]
print(colors[0])       // Red
print(colors.count)    // 3

colors.append("Yellow")  // add to end
colors.remove(at: 1)     // remove "Green"
print(colors)  // ["Red", "Blue", "Yellow"]
"""
                ),
                ContentSection(
                    heading: "Dictionaries",
                    body: "A dictionary stores key-value pairs. Keys are unique; values can repeat. Access values using their key.",
                    codeExample: """
var ages = ["Alice": 30, "Bob": 25, "Carol": 28]

print(ages["Alice"] ?? 0)  // 30
ages["Dave"] = 22          // add new pair
ages["Bob"] = 26           // update existing

for (name, age) in ages {
    print("\\(name) is \\(age)")
}
"""
                ),
                ContentSection(
                    heading: "Useful Collection Methods",
                    body: "Swift collections come with powerful built-in methods for filtering, transforming, and sorting data.",
                    codeExample: """
let numbers = [3, 1, 4, 1, 5, 9, 2, 6]

let sorted  = numbers.sorted()        // [1, 1, 2, 3, 4, 5, 6, 9]
let doubled = numbers.map { $0 * 2 }  // [6, 2, 8, ...]
let evens   = numbers.filter { $0 % 2 == 0 }  // [4, 2, 6]
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "What index does the first element of an array have?",
                    options: ["1", "0", "-1", "It depends"],
                    correctIndex: 1,
                    explanation: "Arrays in Swift (like most languages) are zero-indexed. The first element is at index 0."
                ),
                QuizQuestion(
                    question: "How do you add an element to the end of a Swift array?",
                    options: ["array.add()", "array.push()", "array.append()", "array.insert()"],
                    correctIndex: 2,
                    explanation: "`append(_:)` adds an element to the end of an array."
                ),
                QuizQuestion(
                    question: "In a dictionary, what must be unique?",
                    options: ["Values", "Keys", "Both keys and values", "Neither"],
                    correctIndex: 1,
                    explanation: "Dictionary keys must be unique. Values can repeat."
                )
            ]
        ),

        // MARK: Lesson 7 – Optionals
        Lesson(
            id: 7,
            title: "Optionals",
            subtitle: "Handle values that might be missing",
            emoji: "❓",
            difficulty: .intermediate,
            estimatedMinutes: 9,
            sections: [
                ContentSection(
                    heading: "What is an Optional?",
                    body: "An optional can hold either a value or `nil` (nothing). Add `?` after the type to make it optional. This forces you to handle the \"no value\" case explicitly.",
                    codeExample: """
var username: String? = nil   // no value yet
username = "jeremy"           // now it has a value

var score: Int? = 42
var noScore: Int? = nil       // explicitly empty
"""
                ),
                ContentSection(
                    heading: "Unwrapping with if let",
                    body: "`if let` safely unwraps an optional. The inner block only runs if the optional contains a value.",
                    codeExample: """
var playerName: String? = "Alex"

if let name = playerName {
    print("Welcome, \\(name)!")   // runs if not nil
} else {
    print("No name found.")
}
"""
                ),
                ContentSection(
                    heading: "Nil Coalescing ??",
                    body: "The `??` operator provides a default value if the optional is `nil`. It's a compact alternative to `if let`.",
                    codeExample: """
var nickname: String? = nil
let displayName = nickname ?? "Guest"
print(displayName)  // "Guest"

var savedScore: Int? = 85
let finalScore = savedScore ?? 0
print(finalScore)   // 85
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "What symbol makes a type optional in Swift?",
                    options: ["!", "?", "*", "@"],
                    correctIndex: 1,
                    explanation: "Appending `?` to a type (e.g. `String?`) makes it optional – it can hold either a value or `nil`."
                ),
                QuizQuestion(
                    question: "What does `??` do?",
                    options: [
                        "Force-unwraps an optional",
                        "Checks if two optionals are equal",
                        "Provides a default value if the optional is nil",
                        "Converts optional to non-optional"
                    ],
                    correctIndex: 2,
                    explanation: "`??` is the nil-coalescing operator. `optional ?? default` returns the optional's value if present, or `default` if nil."
                ),
                QuizQuestion(
                    question: "What value does `nil` represent?",
                    options: ["Zero", "False", "Empty string", "The absence of a value"],
                    correctIndex: 3,
                    explanation: "`nil` means there is no value at all – it's different from 0, false, or an empty string."
                )
            ]
        ),

        // MARK: Lesson 8 – Structs & Classes
        Lesson(
            id: 8,
            title: "Structs & Classes",
            subtitle: "Create your own custom types",
            emoji: "🏗️",
            difficulty: .intermediate,
            estimatedMinutes: 10,
            sections: [
                ContentSection(
                    heading: "Structs (Value Types)",
                    body: "A `struct` groups related values together. Structs are value types – when you copy one, you get an independent copy.",
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

var p2 = p1       // independent copy
p2.x = 10        // p1.x is still 3
"""
                ),
                ContentSection(
                    heading: "Classes (Reference Types)",
                    body: "A `class` is similar to a struct but is a reference type – multiple variables can point to the same object. Classes also support inheritance.",
                    codeExample: """
class BankAccount {
    var balance: Double = 0.0
    let owner: String

    init(owner: String, balance: Double) {
        self.owner = owner
        self.balance = balance
    }

    func deposit(_ amount: Double) {
        balance += amount
    }
}

let account = BankAccount(owner: "Jeremy", balance: 100)
account.deposit(50)
print(account.balance)  // 150.0
"""
                ),
                ContentSection(
                    heading: "Struct vs Class",
                    body: "Use a struct for simple data models (coordinates, colors, records). Use a class when you need shared mutable state or inheritance.",
                    codeExample: """
// Rule of thumb:
// ✅ Struct  →  data model, value semantics
// ✅ Class   →  shared state, inheritance, lifecycle

// In SwiftUI, most data models are structs.
// UIKit uses classes for views.
"""
                )
            ],
            quiz: [
                QuizQuestion(
                    question: "Are structs value types or reference types?",
                    options: ["Reference types", "Value types", "Both", "Neither"],
                    correctIndex: 1,
                    explanation: "Structs are value types. Copying a struct creates an independent copy of the data."
                ),
                QuizQuestion(
                    question: "Which feature do classes have that structs do NOT?",
                    options: ["Properties", "Methods", "Inheritance", "Initializers"],
                    correctIndex: 2,
                    explanation: "Classes support inheritance – one class can inherit properties and methods from another. Structs cannot inherit."
                ),
                QuizQuestion(
                    question: "What keyword creates an initializer in a Swift class?",
                    options: ["constructor", "init", "setup", "new"],
                    correctIndex: 1,
                    explanation: "`init` is the initializer method in Swift, used to set up a new instance."
                )
            ]
        )
    ]
}
