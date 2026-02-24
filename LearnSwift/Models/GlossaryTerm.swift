import Foundation

// MARK: - Glossary Term Model

struct GlossaryTerm: Identifiable {
    let id = UUID()
    let term: String
    let emoji: String
    let category: Category
    let oneLiner: String       // Short plain-English definition
    let analogy: String        // Real-world "dumb it down" explanation
    let codeExample: String?   // Optional quick code snippet

    enum Category: String, CaseIterable {
        case basics      = "Basics"
        case controlFlow = "Control Flow"
        case loops       = "Loops"
        case functions   = "Functions"
        case collections = "Collections"
        case oop         = "Object-Oriented"
        case advanced    = "Advanced"
        case swiftUI     = "SwiftUI"
    }

    init(_ term: String, _ emoji: String, _ category: Category,
         oneLiner: String, analogy: String, code: String? = nil) {
        self.term = term
        self.emoji = emoji
        self.category = category
        self.oneLiner = oneLiner
        self.analogy = analogy
        self.codeExample = code
    }
}

// MARK: - All Glossary Terms

extension GlossaryTerm {
    static let all: [GlossaryTerm] = [

        // ─────────────────────────────────────────
        // BASICS
        // ─────────────────────────────────────────
        GlossaryTerm("Variable", "📝", .basics,
            oneLiner: "A named storage box whose value can change.",
            analogy: "Think of a whiteboard. You write something on it, and later you can erase it and write something new. `var score = 0` is you labelling the whiteboard \"score\" and writing 0 on it.",
            code: "var score = 0\nscore = 10  // erase and rewrite"
        ),

        GlossaryTerm("Constant", "🔒", .basics,
            oneLiner: "A named value that can never change once set.",
            analogy: "Like a tattoo. Once it's on you, it stays. You can't say \"actually, change my name tattoo to a different name.\" In Swift, `let` is the tattoo — permanent.",
            code: "let appName = \"LearnSwift\"\n// appName = \"Other\"  ❌ can't change it"
        ),

        GlossaryTerm("String", "💬", .basics,
            oneLiner: "A piece of text — letters, words, sentences, emojis.",
            analogy: "Imagine a necklace made of letter beads. Each bead is one character. String them together and you get a word or sentence. Swift lets you add beads, count them, or look at specific ones.",
            code: "var name = \"Jeremy\"\nprint(name.count)  // 6 beads"
        ),

        GlossaryTerm("Int", "🔢", .basics,
            oneLiner: "A whole number — no decimal point.",
            analogy: "Counting apples. You can have 3 apples or 10 apples, but not 3.5 apples. Use `Int` whenever you're counting whole things — lives in a game, number of messages, a person's age.",
            code: "var lives = 3\nvar messages = 100"
        ),

        GlossaryTerm("Double", "📏", .basics,
            oneLiner: "A number with a decimal point — more precise than Int.",
            analogy: "A measuring tape. It can show exactly 175.3 cm — not just 175. Use `Double` for prices, distances, percentages, temperatures, or anything that needs precision.",
            code: "var height = 1.75\nvar price  = 9.99\nvar score  = 98.5"
        ),

        GlossaryTerm("Bool", "💡", .basics,
            oneLiner: "A value that is only ever `true` or `false`.",
            analogy: "A light switch. It's either ON or OFF. Never 'kind of on'. Perfect for yes/no questions: is the user logged in? Did they win? Is the music playing?",
            code: "var isLoggedIn = false\nvar hasWon    = true"
        ),

        GlossaryTerm("Type Inference", "🔮", .basics,
            oneLiner: "Swift figures out a value's type automatically — you don't have to say it.",
            analogy: "Like a smart barista who knows your usual order without you saying it. You write `var age = 25` and Swift goes \"obviously that's an Int, I got it.\" You only need to spell out the type when Swift might guess wrong.",
            code: "var age   = 25       // Swift knows: Int\nvar name  = \"Alex\"   // Swift knows: String\nvar price = 9.99     // Swift knows: Double"
        ),

        GlossaryTerm("Comment", "📌", .basics,
            oneLiner: "Text in your code that Swift completely ignores — it's just for humans.",
            analogy: "A sticky note on a page of a textbook. The book's content (code) is still there, but the sticky note is your personal reminder. Use `//` for one line or `/* */` for a block.",
            code: "// This is a single-line comment\nvar x = 5  // you can put one here too\n\n/* This is a\n   multi-line comment */"
        ),

        GlossaryTerm("print()", "🖨️", .basics,
            oneLiner: "Outputs text to Xcode's debug console so you can see what's happening.",
            analogy: "Shouting into a walkie-talkie during a mission. Nobody sees it in the app — it's just you monitoring what's going on. When something goes wrong, `print` helps you figure out why.",
            code: "print(\"Hello!\")\nvar score = 42\nprint(\"Score is \\(score)\")"
        ),

        // ─────────────────────────────────────────
        // CONTROL FLOW
        // ─────────────────────────────────────────
        GlossaryTerm("if / else", "🚦", .controlFlow,
            oneLiner: "Run different code depending on whether a condition is true or false.",
            analogy: "A traffic light. IF the light is green, drive. ELSE IF it's yellow, slow down. ELSE (it's red), stop. Your code takes a different road depending on the situation.",
            code: "if score >= 90 {\n    print(\"A grade\")\n} else if score >= 70 {\n    print(\"B grade\")\n} else {\n    print(\"Keep studying!\")\n}"
        ),

        GlossaryTerm("switch", "📺", .controlFlow,
            oneLiner: "Check one value against multiple specific cases — cleaner than many if/elses.",
            analogy: "A TV remote. Press button 1 → Channel 1. Press button 2 → Channel 2. Swift's `switch` checks which 'button' was pressed and runs the matching code. Every option must be covered.",
            code: "switch day {\ncase \"Monday\":  print(\"Ugh, Monday\")\ncase \"Friday\":  print(\"Finally!\")\ndefault:        print(\"A normal day\")\n}"
        ),

        GlossaryTerm("guard", "🚧", .controlFlow,
            oneLiner: "Exit early if a condition is NOT met. Keeps code clean by handling failures first.",
            analogy: "A bouncer at a club with a checklist. If you're not on the guest list — you leave immediately. No further discussion. The bouncer (guard) checks upfront so the party inside only has valid guests.",
            code: "func loadUser(_ name: String?) {\n    guard let n = name else {\n        print(\"No name — exit early\")\n        return\n    }\n    print(\"Welcome, \\(n)!\")\n}"
        ),

        GlossaryTerm("Ternary Operator", "🪙", .controlFlow,
            oneLiner: "A compact one-line if/else: `condition ? valueIfTrue : valueIfFalse`",
            analogy: "A coin flip with a pre-decided plan. Heads (true) → do this. Tails (false) → do that. It's the shortcut version of an if/else when you just need to pick one of two values.",
            code: "let score = 75\nlet result = score >= 60 ? \"Pass\" : \"Fail\"\n// result = \"Pass\""
        ),

        // ─────────────────────────────────────────
        // LOOPS
        // ─────────────────────────────────────────
        GlossaryTerm("for-in Loop", "🔄", .loops,
            oneLiner: "Repeat code once for each item in a collection or range.",
            analogy: "A teacher handing back test papers. You go through the stack and give each student their paper one by one. The loop visits every item — no skipping, no repeats.",
            code: "for student in [\"Alice\",\"Bob\",\"Carol\"] {\n    print(\"Hi \\(student)!\")\n}\n\nfor i in 1...5 { print(i) }"
        ),

        GlossaryTerm("while Loop", "🚰", .loops,
            oneLiner: "Keep repeating as long as a condition is true.",
            analogy: "Filling a glass of water. Keep pouring WHILE the glass isn't full. The moment it's full, you stop. If the condition is never false, the loop runs forever — be careful!",
            code: "var water = 0\nwhile water < 10 {\n    water += 1\n}\nprint(\"Full! \\(water)\")"
        ),

        GlossaryTerm("break", "🛑", .loops,
            oneLiner: "Immediately stop and exit a loop.",
            analogy: "An emergency stop button on a treadmill. Doesn't matter how many miles were planned — hit it and everything stops right now.",
            code: "for n in 1...100 {\n    if n == 5 { break }  // stops at 5\n    print(n)\n}"
        ),

        GlossaryTerm("continue", "⏭️", .loops,
            oneLiner: "Skip the rest of this iteration and jump to the next one.",
            analogy: "Skipping a song on Spotify. You don't stop listening to music — you just skip THIS song and go straight to the next one in the playlist.",
            code: "for n in 1...10 {\n    if n % 2 == 0 { continue }  // skip evens\n    print(n)  // prints 1,3,5,7,9\n}"
        ),

        // ─────────────────────────────────────────
        // FUNCTIONS
        // ─────────────────────────────────────────
        GlossaryTerm("Function", "📋", .functions,
            oneLiner: "A named, reusable block of code you can call whenever you need it.",
            analogy: "A recipe card. You write the steps once (define the function), and you can follow those steps as many times as you want (call the function). Nobody rewrites the whole recipe every time they bake cookies.",
            code: "func makeCoffee() {\n    print(\"Boil water\")\n    print(\"Add coffee\")\n    print(\"Done!\")\n}\nmakeCoffee()  // follow the recipe"
        ),

        GlossaryTerm("Parameter", "🧂", .functions,
            oneLiner: "A variable a function receives as input when called.",
            analogy: "The ingredients list at the top of a recipe. \"This recipe needs: 2 cups flour, 1 egg.\" Parameters are what you hand to the function when you call it so it can do its job.",
            code: "func greet(name: String, age: Int) {\n    print(\"Hi \\(name), you are \\(age)!\")\n}\ngreet(name: \"Alex\", age: 25)"
        ),

        GlossaryTerm("Return Value", "🎁", .functions,
            oneLiner: "The output a function gives back after doing its work.",
            analogy: "The finished dish that comes out of the kitchen after you follow a recipe. You put ingredients in (parameters), follow the steps, and get a meal back (return value). Use `->` to say what type comes out.",
            code: "func add(_ a: Int, _ b: Int) -> Int {\n    return a + b\n}\nlet total = add(3, 4)  // total = 7"
        ),

        GlossaryTerm("Closure", "📦", .functions,
            oneLiner: "An anonymous function you can store in a variable or pass to another function.",
            analogy: "A sealed envelope with instructions inside. You write the instructions now, seal the envelope, and hand it to someone to open and follow later. The envelope 'captures' whatever it needs from the world around it when it's sealed.",
            code: "let greet = { (name: String) in\n    print(\"Hello, \\(name)!\")\n}\ngreet(\"Sam\")  // Hello, Sam!"
        ),

        GlossaryTerm("Higher-Order Function", "🏗️", .functions,
            oneLiner: "A function that takes other functions (closures) as arguments.",
            analogy: "A manager who delegates. Instead of doing the work themselves, they take your instructions (a closure) and apply them to the whole team. `map`, `filter`, and `reduce` are all managers.",
            code: "let nums = [1,2,3,4,5]\nlet doubled = nums.map { $0 * 2 }\n// [2, 4, 6, 8, 10]"
        ),

        // ─────────────────────────────────────────
        // COLLECTIONS
        // ─────────────────────────────────────────
        GlossaryTerm("Array", "📚", .collections,
            oneLiner: "An ordered list of values, all the same type. Items have positions starting at 0.",
            analogy: "A numbered shelf at a library. Shelf 0 has the first book, shelf 1 has the second, and so on. You can add books to the end, remove them, or look up any book by its shelf number.",
            code: "var shelf = [\"Swift\", \"Xcode\", \"iOS\"]\nprint(shelf[0])   // \"Swift\" (shelf 0)\nshelf.append(\"SwiftUI\")"
        ),

        GlossaryTerm("Dictionary", "📖", .collections,
            oneLiner: "A collection of key-value pairs. Look up a value using its key.",
            analogy: "An actual dictionary (the book). You look up a word (the key) and get its definition (the value). Each word is unique. You can add new words, update definitions, or remove entries.",
            code: "var capitals = [\"France\": \"Paris\", \"Japan\": \"Tokyo\"]\nprint(capitals[\"France\"] ?? \"?\")\n// \"Paris\""
        ),

        GlossaryTerm("Set", "🫙", .collections,
            oneLiner: "An unordered collection where every item must be unique.",
            analogy: "A jar of unique marbles. Drop the same marble in twice and only one stays. Great when you care about \"do I have this?\" more than \"what order are they in?\" Checking membership is instant.",
            code: "var visited: Set<String> = []\nvisited.insert(\"Paris\")\nvisited.insert(\"Paris\")  // ignored\nprint(visited.count)    // 1"
        ),

        GlossaryTerm("Index", "🏷️", .collections,
            oneLiner: "The position number of an item in an array. Starts at 0.",
            analogy: "Like seat numbers in a cinema, except they start from 0 instead of 1. Seat 0 is the first seat, seat 1 is the second. Apple chose 0 because computers count from 0.",
            code: "let fruits = [\"Apple\", \"Banana\", \"Cherry\"]\nprint(fruits[0])  // Apple\nprint(fruits[2])  // Cherry"
        ),

        // ─────────────────────────────────────────
        // OBJECT-ORIENTED
        // ─────────────────────────────────────────
        GlossaryTerm("Struct", "📄", .oop,
            oneLiner: "A custom value type that groups related data and behaviour.",
            analogy: "A paper form you fill out and photocopy. Every copy is completely independent — if your boss marks up their copy, your copy is untouched. Most of your Swift data models will be structs.",
            code: "struct Person {\n    var name: String\n    var age: Int\n}\nvar a = Person(name: \"Sam\", age: 25)\nvar b = a      // independent copy\nb.age = 30     // a.age is still 25"
        ),

        GlossaryTerm("Class", "🏠", .oop,
            oneLiner: "A custom reference type. Multiple variables can point to the same instance.",
            analogy: "A shared Google Doc. Everyone looking at it sees the same document. If one person changes it, everyone sees the change. Use classes when you need shared, mutable state — or when you need inheritance.",
            code: "class Dog {\n    var name: String\n    init(name: String) { self.name = name }\n}\nlet d1 = Dog(name: \"Rex\")\nlet d2 = d1        // same dog!\nd2.name = \"Buddy\"  // d1.name is also \"Buddy\""
        ),

        GlossaryTerm("Property", "🏷️", .oop,
            oneLiner: "A variable or constant stored inside a struct or class.",
            analogy: "Facts about a person on their ID card. Name, age, height — those are properties. They describe what an object IS, not what it does.",
            code: "struct Car {\n    var brand: String   // property\n    var speed: Double   // property\n    let doors: Int      // constant property\n}"
        ),

        GlossaryTerm("Method", "🎬", .oop,
            oneLiner: "A function defined inside a struct or class — what the object can DO.",
            analogy: "Things a dog can do: bark, sit, fetch, eat. Those are its methods. Properties are what it IS (name, breed, age), methods are what it DOES. Call them with `dog.bark()`.",
            code: "struct Dog {\n    var name: String\n    func bark() { print(\"\\(name) says Woof!\") }\n    func sit()  { print(\"\\(name) sits.\") }\n}\nlet d = Dog(name: \"Rex\")\nd.bark()  // Rex says Woof!"
        ),

        GlossaryTerm("Initializer (init)", "🐣", .oop,
            oneLiner: "A special method that sets up a new instance from scratch.",
            analogy: "Filling out a birth certificate. Before a new person exists in the system, someone has to fill in their name, date of birth, etc. `init` does that for objects — it sets everything up when something is created.",
            code: "class Person {\n    var name: String\n    var age: Int\n    init(name: String, age: Int) {\n        self.name = name\n        self.age  = age\n    }\n}\nlet p = Person(name: \"Alex\", age: 30)"
        ),

        GlossaryTerm("Inheritance", "🧬", .oop,
            oneLiner: "A class that gets all the properties and methods of another class automatically.",
            analogy: "A family tree. You inherit your parents' eye colour, height, and maybe their nose. A `Dog` class that inherits from `Animal` automatically gets everything `Animal` has — and can add its own things on top (like barking).",
            code: "class Animal {\n    func breathe() { print(\"Breathing\") }\n}\nclass Dog: Animal {\n    func bark() { print(\"Woof!\") }\n}\nlet d = Dog()\nd.breathe()  // inherited ✅\nd.bark()     // its own ✅"
        ),

        GlossaryTerm("override", "🎨", .oop,
            oneLiner: "Replace a method from a parent class with your own version.",
            analogy: "Adapting grandma's cookie recipe. You inherited the recipe but you make your own version — more chocolate chips, less sugar. You still call it the same thing, but it works differently.",
            code: "class Animal {\n    func speak() { print(\"...\") }\n}\nclass Cat: Animal {\n    override func speak() { print(\"Meow!\") }\n}\nCat().speak()  // Meow!"
        ),

        GlossaryTerm("Protocol", "📋", .oop,
            oneLiner: "A contract that defines what a type must be able to do.",
            analogy: "A job description. It says 'this role requires: driving a forklift, using a computer, lifting 20kg.' It doesn't say HOW you learned those skills — just that you have them. Any type that conforms to a protocol must implement all its requirements.",
            code: "protocol Greetable {\n    func greet() -> String\n}\nstruct Robot: Greetable {\n    func greet() -> String {\n        \"Beep boop, hello!\"\n    }\n}"
        ),

        GlossaryTerm("Extension", "🏗️", .oop,
            oneLiner: "Add new functionality to an existing type — even ones you didn't write.",
            analogy: "Building an extension onto a house you don't own. You add a new room (method or property) to `Int`, `String`, or any type, without touching the original blueprints.",
            code: "extension Int {\n    var isEven: Bool { self % 2 == 0 }\n}\nprint(4.isEven)  // true\nprint(7.isEven)  // false"
        ),

        GlossaryTerm("Access Control", "🔑", .oop,
            oneLiner: "Rules about who can see and use different parts of your code.",
            analogy: "A keycard system at an office. The public lobby is open to everyone. Staff areas need an employee badge (internal). The server room only the IT team can enter (private). `private` is the most locked-down; `public` is for everyone.",
            code: "class Vault {\n    public  var name = \"Safe\"\n    internal var code = 1234\n    private var secret = \"hidden\"\n}"
        ),

        // ─────────────────────────────────────────
        // ADVANCED
        // ─────────────────────────────────────────
        GlossaryTerm("Optional", "🎁", .advanced,
            oneLiner: "A value that might exist, or might be nil (nothing).",
            analogy: "A wrapped gift box. There might be a present inside, or it might be empty. You can't use the present until you unwrap the box and check. Swift forces you to unwrap optionals safely so you never reach inside an empty box and crash.",
            code: "var name: String? = nil  // empty box\nname = \"Alex\"            // now has something\n\nif let n = name {\n    print(\"Got: \\(n)\")     // safely unwrapped\n}"
        ),

        GlossaryTerm("nil", "🕳️", .advanced,
            oneLiner: "The complete absence of a value.",
            analogy: "An empty box. Not zero, not an empty string, not false — just absolutely nothing. It's different from 0 the same way an empty plate is different from a plate with zero apples on it.",
            code: "var score: Int? = nil      // no score yet\nvar name:  String? = nil   // no name yet"
        ),

        GlossaryTerm("if let", "🔓", .advanced,
            oneLiner: "Safely unwrap an optional — run the block only if a value exists.",
            analogy: "Opening a gift box carefully. You peek inside first: IF there's something in there, take it out and use it. If the box is empty, you go to the else. No crashing into empty boxes!",
            code: "var username: String? = \"Alex\"\nif let name = username {\n    print(\"Hello, \\(name)!\")\n} else {\n    print(\"No username\")\n}"
        ),

        GlossaryTerm("guard let", "🚧", .advanced,
            oneLiner: "Unwrap an optional early — exit immediately if it's nil.",
            analogy: "A security checkpoint at the start of a journey. If your passport (the optional) is missing, you're sent home immediately. The rest of the code after the guard is for people who passed the check.",
            code: "func greet(_ name: String?) {\n    guard let n = name else {\n        print(\"No name — bailing out\")\n        return\n    }\n    // n is safely unwrapped here\n    print(\"Hello, \\(n)!\")\n}"
        ),

        GlossaryTerm("?? (nil coalescing)", "🔀", .advanced,
            oneLiner: "Provide a default value if an optional is nil.",
            analogy: "A backup plan. \"I'll use my packed lunch, OR if I forgot it, I'll buy something.\" `lunch ?? \"buy food\"` — use the optional if it has a value, otherwise use the fallback.",
            code: "var nickname: String? = nil\nlet display = nickname ?? \"Guest\"\nprint(display)  // \"Guest\""
        ),

        GlossaryTerm("Enum", "🍽️", .advanced,
            oneLiner: "A type with a fixed set of named cases — you can only pick from the list.",
            analogy: "A restaurant menu. You can only order what's listed. You can't say \"I'll have a unicorn burger\" — it's not on the menu. Enums prevent invalid values by limiting choices to exactly what you define.",
            code: "enum Season { case spring, summer, autumn, winter }\nvar now = Season.summer\n\nswitch now {\ncase .summer: print(\"It's hot!\")\ncase .winter: print(\"It's cold!\")\ndefault: print(\"In between\")\n}"
        ),

        GlossaryTerm("Generic", "🔌", .advanced,
            oneLiner: "Code that works with any type instead of one specific type.",
            analogy: "A universal charger. Instead of making a separate charger for every phone brand, you make one that works with all of them. Generics let you write a function or type once that works for Int, String, or anything else.",
            code: "func printTwice<T>(_ value: T) {\n    print(value)\n    print(value)\n}\nprintTwice(42)        // works!\nprintTwice(\"hello\")   // works too!"
        ),

        GlossaryTerm("Error Handling", "🪂", .advanced,
            oneLiner: "A structured way to deal with things that can go wrong.",
            analogy: "A parachute on a skydive. You hope you don't need it, but it's always there. `throws` marks the risky jump. `do-catch` is the parachute that catches you if things go wrong.",
            code: "enum AppError: Error { case notFound }\nfunc load() throws -> String {\n    throw AppError.notFound\n}\ndo {\n    let r = try load()\n    print(r)\n} catch {\n    print(\"Caught: \\(error)\")\n}"
        ),

        GlossaryTerm("ARC (Memory Management)", "📚", .advanced,
            oneLiner: "Swift automatically tracks how many things are using each object and frees memory when nothing needs it.",
            analogy: "A library checkout system. A book stays in the library as long as at least one person has it checked out. The moment the last person returns it (no more references), the library reclaims the shelf space. You rarely need to think about this — Swift does it for you.",
            code: "class Dog {\n    let name: String\n    init(_ name: String) { self.name = name }\n    deinit { print(\"\\(name) gone\") }\n}\nvar d: Dog? = Dog(\"Rex\")\nd = nil  // no references left → deinit called"
        ),

        GlossaryTerm("weak reference", "🤝", .advanced,
            oneLiner: "A reference that doesn't prevent the object from being deallocated.",
            analogy: "A casual \"let me know if you're still around\" friendship. You're not blocking their ability to leave. If they move away (get deallocated), your reference becomes `nil` automatically. Used to break retain cycles.",
            code: "class Owner {\n    var pet: Pet?\n}\nclass Pet {\n    weak var owner: Owner?  // won't prevent dealloc\n}"
        ),

        GlossaryTerm("async / await", "⏳", .advanced,
            oneLiner: "Write asynchronous (background) code that reads like normal step-by-step code.",
            analogy: "Ordering food at a restaurant. You give your order to the waiter (start the async task), then sit and relax — you don't stand at the kitchen window watching. When the food's ready, the waiter brings it to you (the `await` resumes). Other people keep getting served in the meantime.",
            code: "func fetchData() async -> String {\n    // imagine a real network call here\n    return \"Data loaded!\"\n}\n\nTask {\n    let result = await fetchData()\n    print(result)\n}"
        ),

        GlossaryTerm("Result<T, E>", "⚖️", .advanced,
            oneLiner: "An enum representing either a success value or a failure error.",
            analogy: "A report card that either says 'Passed — here's your grade' or 'Failed — here's the reason'. You get one or the other, never both. Great for returning results from functions that can fail.",
            code: "func divide(_ a: Int, _ b: Int) -> Result<Int, Error> {\n    guard b != 0 else { return .failure(...) }\n    return .success(a / b)\n}\nswitch divide(10, 2) {\ncase .success(let v): print(v)\ncase .failure(let e): print(e)\n}"
        ),

        GlossaryTerm("inout", "🔁", .advanced,
            oneLiner: "Lets a function modify the original variable, not just a copy.",
            analogy: "A mechanic working on your actual car, not a replica. Normally functions get a copy of your data. `inout` hands them the keys to the real thing. Any changes they make stick after the function ends. Pass with `&`.",
            code: "func doubleIt(_ n: inout Int) {\n    n *= 2\n}\nvar x = 5\ndoubleIt(&x)\nprint(x)  // 10"
        ),

        // ─────────────────────────────────────────
        // SWIFTUI
        // ─────────────────────────────────────────
        GlossaryTerm("View", "🧱", .swiftUI,
            oneLiner: "The basic building block of any SwiftUI screen.",
            analogy: "A Lego brick. Every single thing you see on a SwiftUI screen is a View — buttons, text, images, spacers. You snap Views together to build screens, just like snapping Lego bricks to build models.",
            code: "struct MyView: View {\n    var body: some View {\n        Text(\"Hello!\")\n    }\n}"
        ),

        GlossaryTerm("@State", "📝", .swiftUI,
            oneLiner: "A property wrapper that stores local, mutable state inside a SwiftUI view.",
            analogy: "A sticky note inside the view's pocket. When you update the sticky note, the whole view redraws itself automatically to reflect the change. It's the view's personal notepad.",
            code: "struct Counter: View {\n    @State private var count = 0\n    var body: some View {\n        Button(\"Tapped \\(count)\") { count += 1 }\n    }\n}"
        ),

        GlossaryTerm("@Binding", "🔗", .swiftUI,
            oneLiner: "A two-way connection to state owned by a parent view.",
            analogy: "A shared Google Doc link. The parent view owns the document (@State), and passes a link to child views (@Binding). Either the parent or the child can edit it, and both see the update instantly.",
            code: "// Parent passes $toggle (binding)\nstruct Parent: View {\n    @State var isOn = false\n    var body: some View {\n        Toggle(\"Switch\", isOn: $isOn)\n    }\n}"
        ),

        GlossaryTerm("Modifier", "👗", .swiftUI,
            oneLiner: "A method chained onto a view to change its appearance or behaviour.",
            analogy: "Clothing and accessories. A view is the person; modifiers are their outfit. `.bold()` is a tie, `.padding()` is a puffy coat, `.background(.blue)` is a blue shirt. You can layer as many as you want.",
            code: "Text(\"Hello\")\n    .font(.title)\n    .bold()\n    .foregroundColor(.white)\n    .padding()\n    .background(.blue)\n    .cornerRadius(10)"
        ),

        GlossaryTerm("NavigationStack", "📚", .swiftUI,
            oneLiner: "A container that enables pushing and popping screens (back button navigation).",
            analogy: "A stack of paper on a desk. Each new screen you navigate to gets placed on top of the pile. The back button removes the top sheet. The stack manages the whole history.",
            code: "NavigationStack {\n    List([\"A\", \"B\"], id: \\.self) { item in\n        NavigationLink(item) {\n            Text(\"You tapped \\(item)\")\n        }\n    }\n    .navigationTitle(\"Home\")\n}"
        ),

        GlossaryTerm("List", "📋", .swiftUI,
            oneLiner: "A scrollable, vertical list of rows — like your phone's contacts or Settings app.",
            analogy: "Your iPhone contacts list. Each row is a view. Scroll up and down. Tap a row to navigate. Swipe to delete. SwiftUI's `List` handles all of that with very little code.",
            code: "List([\"Coffee\", \"Tea\", \"Water\"], id: \\.self) {\n    Text($0)\n}"
        ),

        GlossaryTerm("@StateObject", "🏭", .swiftUI,
            oneLiner: "Creates and owns an ObservableObject for the lifetime of the view.",
            analogy: "Hiring and managing a full-time employee. The view that uses `@StateObject` is the employer — it creates the object and keeps it alive. Use this in the view that 'owns' the data model.",
            code: "class ViewModel: ObservableObject {\n    @Published var name = \"Swift\"\n}\nstruct MyView: View {\n    @StateObject var vm = ViewModel()\n    var body: some View { Text(vm.name) }\n}"
        ),

        GlossaryTerm("@Published", "📡", .swiftUI,
            oneLiner: "Marks a property that should trigger a SwiftUI view update when it changes.",
            analogy: "A breaking news alert on your phone. When this specific piece of data changes, it broadcasts a notification to everyone who's listening (any view observing the object). Without `@Published`, changes happen silently.",
            code: "class Store: ObservableObject {\n    @Published var cartCount = 0  // views update!\n    var storeID = \"123\"  // views don't update\n}"
        ),

        GlossaryTerm("Sheet", "🃏", .swiftUI,
            oneLiner: "A modal card that slides up from the bottom of the screen.",
            analogy: "The Apple Pay confirmation screen, or the share sheet when you tap the share button. It slides up over the current screen and you dismiss it by swiping down. Great for quick tasks without navigating to a whole new screen.",
            code: "struct MyView: View {\n    @State var showSheet = false\n    var body: some View {\n        Button(\"Open\") { showSheet = true }\n            .sheet(isPresented: $showSheet) {\n                Text(\"I'm a sheet!\")\n            }\n    }\n}"
        ),

        GlossaryTerm("ForEach", "🔢", .swiftUI,
            oneLiner: "Loop over a collection and create a view for each item.",
            analogy: "An assembly line. You pass a list of parts (your data) and for each part, a worker (the closure) builds one piece of UI. Stack as many rows, cards, or buttons as you have items — automatically.",
            code: "let fruits = [\"Apple\", \"Banana\", \"Cherry\"]\nForEach(fruits, id: \\.self) { fruit in\n    Text(fruit)\n}"
        ),
    ]
}
