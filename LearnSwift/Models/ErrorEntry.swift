import Foundation

struct ErrorEntry: Identifiable {
    let id = UUID()
    let errorMessage: String   // exactly how Xcode displays it
    let emoji: String
    let plainEnglish: String   // what it means in plain English
    let whyItHappens: String   // common cause
    let howToFix: String       // fix instructions
    let badCode: String?       // code that causes the error
    let goodCode: String?      // the fixed version
}

struct ErrorData {
    static let all: [ErrorEntry] = [

        ErrorEntry(
            errorMessage: "Cannot find type 'X' in scope",
            emoji: "🔍",
            plainEnglish: "Swift can't find a type with that name anywhere in your project. It's like referencing a person by name who doesn't exist in your contacts.",
            whyItHappens: "You misspelled the type name, forgot to import the framework that defines it, or you're trying to use a type defined in another file that hasn't been created yet.",
            howToFix: "Check the spelling carefully (types are case-sensitive). Make sure the file that defines the type is in your project. If it's a framework type like Color or URL, confirm you have `import SwiftUI` or `import Foundation` at the top of the file.",
            badCode: "var color: Colour = .red  // typo — should be Color",
            goodCode: "var color: Color = .red"
        ),

        ErrorEntry(
            errorMessage: "Value of type 'X' has no member 'Y'",
            emoji: "❓",
            plainEnglish: "You're trying to use a property or method that doesn't exist on that type. Like asking your Calculator app to play music.",
            whyItHappens: "You misspelled a property or method name, or you're calling something on the wrong type. This often happens when Xcode infers a different type than you expected.",
            howToFix: "Use Xcode's autocomplete (start typing and press Tab or Esc) to see what members are actually available. Check the type of the variable — it might not be what you think. Option-click the variable name to see its type.",
            badCode: "let name = \"Alice\"\nprint(name.lenght)  // typo — should be count",
            goodCode: "let name = \"Alice\"\nprint(name.count)"
        ),

        ErrorEntry(
            errorMessage: "Cannot convert value of type 'X' to specified type 'Y'",
            emoji: "🔄",
            plainEnglish: "You're trying to put the wrong type of thing in a box that expects a different type. Like trying to fit a square peg in a round hole.",
            whyItHappens: "Swift is strictly typed — you can't mix types without explicit conversion. Common cases: passing a String where an Int is expected, or assigning a Double to an Int variable.",
            howToFix: "Convert explicitly using type initializers: `Int(someDouble)`, `String(someInt)`, `Double(someInt)`. Or change the type annotation to match what you're storing.",
            badCode: "let age: Int = \"25\"  // String can't go into Int",
            goodCode: "let age: Int = 25\n// or\nlet ageString = \"25\"\nlet age = Int(ageString) ?? 0"
        ),

        ErrorEntry(
            errorMessage: "Use of unresolved identifier 'X'",
            emoji: "👻",
            plainEnglish: "You're using a variable, constant, or function name that Swift has never heard of. It's like referencing a local variable from a different city — it doesn't exist in this scope.",
            whyItHappens: "The variable was declared inside a different scope (like inside an if block), you have a typo in the name, or you forgot to declare it before using it.",
            howToFix: "Make sure the variable is declared before it's used. Check that it's declared in the right scope — variables declared inside `{ }` blocks only live there. Look for typos in the name.",
            badCode: "func calculate() {\n    if true {\n        let result = 42\n    }\n    print(result)  // result doesn't exist here\n}",
            goodCode: "func calculate() {\n    var result = 0\n    if true {\n        result = 42\n    }\n    print(result)  // works — result is in scope\n}"
        ),

        ErrorEntry(
            errorMessage: "Missing return in function expected to return 'X'",
            emoji: "↩️",
            plainEnglish: "Your function promises to hand back a value, but there's a code path where it forgets to return anything. Like a vending machine that takes your money but sometimes gives you nothing.",
            whyItHappens: "You declared a return type (like `-> Int`) but didn't include a `return` statement on every possible path through the function, especially inside if/else blocks.",
            howToFix: "Make sure every branch of your function ends with a `return` statement that matches the return type. If you have an if/else, both branches need to return.",
            badCode: "func grade(score: Int) -> String {\n    if score >= 60 {\n        return \"Pass\"\n    }\n    // What happens if score < 60? Missing return!\n}",
            goodCode: "func grade(score: Int) -> String {\n    if score >= 60 {\n        return \"Pass\"\n    } else {\n        return \"Fail\"\n    }\n}"
        ),

        ErrorEntry(
            errorMessage: "Cannot assign to value: 'X' is a 'let' constant",
            emoji: "🔒",
            plainEnglish: "You declared this value as a constant with `let`, which means it can never change. You're trying to modify something that's locked.",
            whyItHappens: "You used `let` to declare a variable that you later need to change, or you're trying to modify a property on a `let` struct instance.",
            howToFix: "Change `let` to `var` if the value needs to change. If you're working with a struct passed into a function, remember structs are value types — you'd need to pass by reference or use a class.",
            badCode: "let score = 0\nscore += 10  // Error: score is a constant",
            goodCode: "var score = 0\nscore += 10  // Works — score is a variable"
        ),

        ErrorEntry(
            errorMessage: "Thread 1: Fatal error: Index out of range",
            emoji: "💥",
            plainEnglish: "You tried to access an array position that doesn't exist. Imagine asking for the 10th item in a 5-item list — it's not there.",
            whyItHappens: "Accessing `array[index]` where `index` is larger than `array.count - 1`, or using a negative index. Arrays in Swift start at index 0.",
            howToFix: "Always check that the index is valid before accessing it: `if index < array.count`. Or use `array.first` / `array.last` which return optionals instead of crashing.",
            badCode: "let names = [\"Alice\", \"Bob\"]\nprint(names[2])  // Index 2 doesn't exist! (0 and 1 do)",
            goodCode: "let names = [\"Alice\", \"Bob\"]\nif 2 < names.count {\n    print(names[2])\n} else {\n    print(\"Index doesn't exist\")\n}"
        ),

        ErrorEntry(
            errorMessage: "Thread 1: Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value",
            emoji: "💣",
            plainEnglish: "Something declared as ImplicitlyUnwrappedOptional (with `!`) turned out to be nil at the moment you used it, causing an immediate crash.",
            whyItHappens: "IBOutlets declared with `!` crash if the view hasn't loaded yet. Using `!` to force-unwrap an optional that is actually nil. Over-relying on `!` in general.",
            howToFix: "Replace `!` with safe unwrapping using `if let` or `guard let`. For IBOutlets, make sure you're only accessing them after `viewDidLoad`. Treat every `!` in your code as a potential crash waiting to happen.",
            badCode: "var username: String!\n// ... username is never assigned ...\nprint(username.count)  // CRASH — username is nil",
            goodCode: "var username: String?\n// Safe unwrapping:\nif let name = username {\n    print(name.count)\n}"
        ),

        ErrorEntry(
            errorMessage: "Expression is unused",
            emoji: "🗑️",
            plainEnglish: "You wrote an expression or called a function that produces a value, but you didn't do anything with that value. It's like doing a calculation and then throwing away the result.",
            whyItHappens: "Forgetting to assign the result of a function to a variable. Calling a method that returns something when you meant to call a method that modifies in place (like calling `.sorted()` instead of `.sort()`).",
            howToFix: "Either store the result in a variable/constant, or if you genuinely don't need it, use `_ = expression` to silence the warning.",
            badCode: "var names = [\"Bob\", \"Alice\"]\nnames.sorted()  // sorted() returns a NEW array, this is thrown away",
            goodCode: "var names = [\"Bob\", \"Alice\"]\nlet sorted = names.sorted()  // store the result\n// or\nnames.sort()  // sort() modifies names in place"
        ),

        ErrorEntry(
            errorMessage: "No exact matches in call to instance method 'X'",
            emoji: "🎯",
            plainEnglish: "You're calling a function with arguments that don't match any version of that function. It's like dialing a phone number with the wrong number of digits.",
            whyItHappens: "Passing the wrong type as an argument, missing a required argument, using incorrect argument labels, or passing too many/few arguments.",
            howToFix: "Option-click the function name to see its full signature and parameter types. Check that each argument label matches and each value is the right type.",
            badCode: "let value = Double(\"hello\")  // OK, returns nil\nlet result = Int(3.7, roundingRule: .up)  // Wrong overload",
            goodCode: "let result = Int(3.7)  // Truncates to 3\n// or\nlet result = Int(exactly: 3.0)  // Returns Optional"
        ),

        ErrorEntry(
            errorMessage: "Type 'X' does not conform to protocol 'Identifiable'",
            emoji: "🪪",
            plainEnglish: "SwiftUI's List and ForEach need each item to have a unique ID so they can track changes. Your type doesn't have one.",
            whyItHappens: "Using a custom struct in a SwiftUI `List` or `ForEach` without conforming to `Identifiable`, which requires an `id` property.",
            howToFix: "Add `let id = UUID()` to your struct and conform to `Identifiable`. Or use `ForEach(items, id: \\.someUniqueProperty)` to specify the ID without conforming.",
            badCode: "struct Task {\n    var title: String\n}\n\nList(tasks) { task in  // Error: Task not Identifiable\n    Text(task.title)\n}",
            goodCode: "struct Task: Identifiable {\n    let id = UUID()\n    var title: String\n}\n\nList(tasks) { task in  // Works!\n    Text(task.title)\n}"
        ),

        ErrorEntry(
            errorMessage: "Variable 'X' used before being initialized",
            emoji: "🧱",
            plainEnglish: "You declared a variable but tried to use it before giving it a value. It's like trying to read from an empty box.",
            whyItHappens: "Declaring a variable with `var x: Type` without an initial value, and then using it before all code paths have assigned a value to it.",
            howToFix: "Give the variable an initial value when you declare it, or ensure all code paths assign a value before the variable is first read.",
            badCode: "var message: String\n// ... forgot to assign ...\nprint(message)  // Error: not initialized",
            goodCode: "var message: String = \"\"\n// or\nvar message: String\nmessage = \"Hello\"\nprint(message)"
        ),

        ErrorEntry(
            errorMessage: "'mutating' is only valid on methods in a struct or enum",
            emoji: "🏗️",
            plainEnglish: "You used the `mutating` keyword on a method inside a class. Classes don't need it — only structs and enums do.",
            whyItHappens: "Copying code or patterns from a struct into a class without removing `mutating`. Classes are reference types, so they can always modify their own properties.",
            howToFix: "Simply remove the `mutating` keyword from the class method. It only belongs in structs and enums.",
            badCode: "class Counter {\n    var count = 0\n    mutating func increment() {  // Error: class doesn't need mutating\n        count += 1\n    }\n}",
            goodCode: "class Counter {\n    var count = 0\n    func increment() {  // No mutating needed in a class\n        count += 1\n    }\n}"
        ),

        ErrorEntry(
            errorMessage: "Referencing operator function '==' requires that 'X' conform to 'Equatable'",
            emoji: "⚖️",
            plainEnglish: "You're trying to compare two values with `==`, but Swift doesn't know how to compare your custom type. You need to tell it what \"equal\" means.",
            whyItHappens: "Using `==` on a custom struct or class that hasn't adopted the `Equatable` protocol. Swift can't automatically compare custom types without guidance.",
            howToFix: "Add `: Equatable` to your struct. If all stored properties are themselves Equatable, Swift will synthesize the `==` implementation for free. For classes or complex cases, implement `==` manually.",
            badCode: "struct Point {\n    var x: Int\n    var y: Int\n}\nlet a = Point(x: 1, y: 2)\nlet b = Point(x: 1, y: 2)\nif a == b { }  // Error: Point not Equatable",
            goodCode: "struct Point: Equatable {\n    var x: Int\n    var y: Int\n}\nlet a = Point(x: 1, y: 2)\nlet b = Point(x: 1, y: 2)\nif a == b { print(\"Equal\") }  // Works!"
        ),

        ErrorEntry(
            errorMessage: "Cannot use mutating member on immutable value: 'self' is immutable",
            emoji: "🧊",
            plainEnglish: "You're calling a mutating method on a struct that was declared with `let`. An immutable struct cannot be modified.",
            whyItHappens: "Declaring a struct instance with `let` and then calling a `mutating` method on it, or trying to modify its properties.",
            howToFix: "Change `let` to `var` for the struct instance so it can be mutated.",
            badCode: "struct Counter {\n    var count = 0\n    mutating func increment() { count += 1 }\n}\nlet c = Counter()   // declared with let\nc.increment()       // Error: c is immutable",
            goodCode: "var c = Counter()   // changed to var\nc.increment()       // Works!"
        ),

        ErrorEntry(
            errorMessage: "Property initializer runs before 'self' is available",
            emoji: "🐣",
            plainEnglish: "You're trying to use one property to set the initial value of another property, but at that point the object doesn't fully exist yet.",
            whyItHappens: "Referencing `self` or another stored property in a stored property's default value expression, like `var doubled = self.value * 2`.",
            howToFix: "Move the computation into an `init` method where `self` is fully available, or use a lazy property.",
            badCode: "struct Rectangle {\n    var width = 10\n    var area = width * 20  // Error: can't reference 'width' here\n}",
            goodCode: "struct Rectangle {\n    var width = 10\n    var area: Int { width * 20 }  // computed property — works!\n}\n// or\nstruct Rectangle {\n    var width: Int\n    var area: Int\n    init(width: Int) {\n        self.width = width\n        self.area = width * 20\n    }\n}"
        ),

        ErrorEntry(
            errorMessage: "Initializer is inaccessible due to 'private' protection level",
            emoji: "🚪",
            plainEnglish: "The init method for this type is marked `private`, meaning you can't create an instance of it from outside the file or type where it's defined.",
            whyItHappens: "The type was intentionally designed as a singleton (like `StreakManager.shared`) or a factory pattern where direct initialization is prevented.",
            howToFix: "Use the provided static factory method or shared instance instead of calling `init()` directly. If you own the code, change `private init()` to `init()` if that was not intentional.",
            badCode: "class AppConfig {\n    private init() { }\n    static let shared = AppConfig()\n}\nlet config = AppConfig()  // Error: init is private",
            goodCode: "let config = AppConfig.shared  // Use the singleton instance"
        ),

        ErrorEntry(
            errorMessage: "Result of call to function returning 'X' is unused",
            emoji: "♻️",
            plainEnglish: "You called a function that returns a value, but you didn't store or use that value anywhere. Swift is warning you this might be a mistake.",
            whyItHappens: "Forgetting to assign the return value to a variable. This is common when calling methods like `.map`, `.filter`, or `.sorted` without capturing the result.",
            howToFix: "Assign the result to a variable with `let result = ...`, or if you truly don't need it, write `_ = functionCall()` to explicitly discard it.",
            badCode: "let numbers = [3, 1, 2]\nnumbers.sorted()  // The sorted array is created and immediately thrown away",
            goodCode: "let numbers = [3, 1, 2]\nlet sorted = numbers.sorted()  // Now the result is captured\nprint(sorted)"
        ),

        ErrorEntry(
            errorMessage: "Closure containing a declaration cannot be used with result builder 'ViewBuilder'",
            emoji: "🏗️",
            plainEnglish: "SwiftUI's view builder magic doesn't allow certain Swift statements inside view closures. You can't use `let` declarations that aren't simple value assignments in some contexts.",
            whyItHappens: "Putting a `struct`, `class`, `func`, or complex `let` declaration directly inside a SwiftUI view body closure where ViewBuilder expects only view expressions.",
            howToFix: "Move declarations outside the view body, use computed properties, or extract the logic into a separate function or view.",
            badCode: "var body: some View {\n    let doubled = { (n: Int) -> Int in return n * 2 }  // Can't declare func/closure here\n    Text(\"\\(doubled(5))\")\n}",
            goodCode: "func doubled(_ n: Int) -> Int { n * 2 }  // Moved outside body\n\nvar body: some View {\n    Text(\"\\(doubled(5))\")\n}"
        ),

        ErrorEntry(
            errorMessage: "Extra trailing closure passed in call",
            emoji: "🪝",
            plainEnglish: "You added a trailing closure `{ }` to a function call, but the function doesn't accept a closure as a parameter (or already has all its closures filled).",
            whyItHappens: "Misremembering a function's signature, accidentally adding `{ }` after a function that returns a value but takes no closure, or using trailing closure syntax where it doesn't apply.",
            howToFix: "Remove the trailing closure, or check the function's actual signature with Option+Click to see what parameters it accepts.",
            badCode: "let names = [\"Alice\", \"Bob\"]\nlet count = names.count { $0.count > 3 }  // count is a property, not a function with closure",
            goodCode: "let names = [\"Alice\", \"Bob\"]\nlet count = names.count  // just a property\n// or if you want filtered count:\nlet longNames = names.filter { $0.count > 3 }.count"
        ),
    ]
}
