import Foundation

struct Flashcard: Identifiable {
    let id = UUID()
    let category: String
    let front: String  // the question/prompt
    let back: String   // the answer
}

struct FlashcardData {
    static let all: [Flashcard] = [

        // MARK: - Swift Basics (10)
        Flashcard(
            category: "Swift Basics",
            front: "How do you declare a constant?",
            back: "let name = value\n\nExample:\nlet maxScore = 100\nlet appName = \"LearnSwift\""
        ),
        Flashcard(
            category: "Swift Basics",
            front: "How do you declare a variable?",
            back: "var name = value\n\nExample:\nvar score = 0\nvar username = \"Alice\"\n\nUse var when the value needs to change."
        ),
        Flashcard(
            category: "Swift Basics",
            front: "What is type inference?",
            back: "Swift automatically figures out the type from the value you assign.\n\nExample:\nlet age = 25        // inferred as Int\nlet price = 9.99    // inferred as Double\nlet name = \"Alice\"  // inferred as String\n\nYou don't have to write the type explicitly."
        ),
        Flashcard(
            category: "Swift Basics",
            front: "How do you explicitly declare a type?",
            back: "let name: Type = value\n\nExample:\nlet score: Int = 0\nlet label: String = \"Hello\"\nlet ratio: Double = 0.5\n\nUseful when the type isn't obvious from the value."
        ),
        Flashcard(
            category: "Swift Basics",
            front: "What are the 4 most common Swift types?",
            back: "Int    — whole numbers (1, 42, -7)\nDouble — decimal numbers (3.14, 0.5)\nString — text (\"Hello\")\nBool   — true or false\n\nExample:\nlet count: Int = 10\nlet pi: Double = 3.14\nlet greeting: String = \"Hi\"\nlet isLoggedIn: Bool = false"
        ),
        Flashcard(
            category: "Swift Basics",
            front: "How does string interpolation work?",
            back: "Embed values inside a string using \\(value)\n\nExample:\nlet name = \"Alice\"\nlet age = 30\nlet message = \"\\(name) is \\(age) years old.\"\n// → \"Alice is 30 years old.\"\n\nCleaner than using + to join strings."
        ),
        Flashcard(
            category: "Swift Basics",
            front: "How do you print to the console?",
            back: "print(value)\n\nExample:\nprint(\"Hello, World!\")\nprint(score)\nprint(\"Score: \\(score)\")\n\nOutput appears in Xcode's debug console at the bottom."
        ),
        Flashcard(
            category: "Swift Basics",
            front: "How do you write a single-line comment?",
            back: "// Your comment here\n\nExample:\n// Calculate the total price\nlet total = price * quantity\n\nComments are ignored by the compiler — they're notes for humans."
        ),
        Flashcard(
            category: "Swift Basics",
            front: "How do you write a multi-line comment?",
            back: "/* Your comment\n   spanning multiple lines */\n\nExample:\n/* This function calculates tax.\n   It does not include shipping.\n   Updated: 2025 */\nfunc calculateTax() { }"
        ),
        Flashcard(
            category: "Swift Basics",
            front: "What is the difference between Int and Double?",
            back: "Int holds whole numbers only.\nDouble holds decimal (floating-point) numbers.\n\nExample:\nlet apples: Int = 5\nlet price: Double = 2.99\n\nYou can't mix them directly:\nlet total = Double(apples) * price  // must convert"
        ),

        // MARK: - Control Flow (8)
        Flashcard(
            category: "Control Flow",
            front: "What is the basic if/else syntax?",
            back: "if condition {\n    // runs if true\n} else {\n    // runs if false\n}\n\nExample:\nif score >= 60 {\n    print(\"Pass\")\n} else {\n    print(\"Fail\")\n}"
        ),
        Flashcard(
            category: "Control Flow",
            front: "How do you write if / else if / else?",
            back: "if condition1 {\n    // ...\n} else if condition2 {\n    // ...\n} else {\n    // fallback\n}\n\nExample:\nif grade >= 90 {\n    print(\"A\")\n} else if grade >= 80 {\n    print(\"B\")\n} else {\n    print(\"C or below\")\n}"
        ),
        Flashcard(
            category: "Control Flow",
            front: "What is the switch statement syntax?",
            back: "switch value {\ncase x:\n    // ...\ncase y:\n    // ...\ndefault:\n    // fallback\n}\n\nExample:\nswitch day {\ncase \"Monday\":\n    print(\"Start of week\")\ncase \"Friday\":\n    print(\"Almost weekend\")\ndefault:\n    print(\"Midweek\")\n}"
        ),
        Flashcard(
            category: "Control Flow",
            front: "What does guard let do?",
            back: "guard let unwrapped = optional else {\n    return  // exit early\n}\n// use unwrapped here\n\nExample:\nfunc greet(_ name: String?) {\n    guard let name = name else {\n        print(\"No name\")\n        return\n    }\n    print(\"Hello, \\(name)\")\n}\n\nKeeps your main logic un-indented."
        ),
        Flashcard(
            category: "Control Flow",
            front: "What is the ternary operator?",
            back: "condition ? valueIfTrue : valueIfFalse\n\nExample:\nlet label = score >= 60 ? \"Pass\" : \"Fail\"\nlet icon = isOn ? \"checkmark\" : \"xmark\"\n\nGreat for short, simple conditions. Avoid nesting them."
        ),
        Flashcard(
            category: "Control Flow",
            front: "How do you match a range in a switch case?",
            back: "Use the range operator inside a case:\n\nswitch score {\ncase 90...100:\n    print(\"A\")\ncase 80..<90:\n    print(\"B\")\ncase 0..<80:\n    print(\"Below B\")\ndefault:\n    print(\"Invalid\")\n}"
        ),
        Flashcard(
            category: "Control Flow",
            front: "What is the difference between == and ===?",
            back: "== checks if two values are equal.\n=== checks if two objects point to the same instance (reference equality).\n\nExample:\nlet a = \"hello\"\nlet b = \"hello\"\na == b   // true — same value\n\n=== only applies to class instances, not structs or strings."
        ),
        Flashcard(
            category: "Control Flow",
            front: "How do you use if let to unwrap an optional?",
            back: "if let unwrapped = optional {\n    // use unwrapped safely\n}\n\nExample:\nlet username: String? = \"Alice\"\nif let name = username {\n    print(\"Hello, \\(name)\")\n} else {\n    print(\"No user\")\n}"
        ),

        // MARK: - Loops (6)
        Flashcard(
            category: "Loops",
            front: "How do you loop over a range of numbers?",
            back: "for i in 1...5 {\n    print(i)  // 1, 2, 3, 4, 5\n}\n\nfor i in 0..<5 {\n    print(i)  // 0, 1, 2, 3, 4\n}\n\n... includes the last number.\n..< excludes the last number."
        ),
        Flashcard(
            category: "Loops",
            front: "How do you loop over an array?",
            back: "for item in array {\n    // use item\n}\n\nExample:\nlet fruits = [\"apple\", \"banana\", \"cherry\"]\nfor fruit in fruits {\n    print(fruit)\n}\n\nTo also get the index:\nfor (i, fruit) in fruits.enumerated() {\n    print(\"\\(i): \\(fruit)\")\n}"
        ),
        Flashcard(
            category: "Loops",
            front: "What is the while loop syntax?",
            back: "while condition {\n    // repeats while condition is true\n}\n\nExample:\nvar count = 0\nwhile count < 5 {\n    print(count)\n    count += 1\n}\n\nMake sure the condition eventually becomes false, or it loops forever."
        ),
        Flashcard(
            category: "Loops",
            front: "What is a repeat-while loop?",
            back: "repeat {\n    // runs at least once\n} while condition\n\nExample:\nvar attempts = 0\nrepeat {\n    attempts += 1\n    print(\"Attempt \\(attempts)\")\n} while attempts < 3\n\nDifference from while: the body always runs at least once."
        ),
        Flashcard(
            category: "Loops",
            front: "What is the difference between break and continue?",
            back: "break  — exits the loop entirely.\ncontinue — skips the rest of the current iteration and goes to the next.\n\nExample:\nfor i in 1...5 {\n    if i == 3 { continue }  // skip 3\n    if i == 5 { break }     // stop at 5\n    print(i)                 // prints 1, 2, 4\n}"
        ),
        Flashcard(
            category: "Loops",
            front: "How do you use _ in a for loop when you don't need the index?",
            back: "Use _ to ignore the loop variable:\n\nfor _ in 1...3 {\n    print(\"Hello\")\n}\n// Prints \"Hello\" three times\n\nThis tells Swift you know there's a variable but you don't care about its value."
        ),

        // MARK: - Functions (6)
        Flashcard(
            category: "Functions",
            front: "How do you define a basic function?",
            back: "func functionName() {\n    // body\n}\n\nExample:\nfunc sayHello() {\n    print(\"Hello!\")\n}\n\nCall it with:\nsayHello()"
        ),
        Flashcard(
            category: "Functions",
            front: "How do you define a function with parameters?",
            back: "func name(label param: Type) {\n    // use param\n}\n\nExample:\nfunc greet(name: String) {\n    print(\"Hello, \\(name)!\")\n}\n\ngreet(name: \"Alice\")"
        ),
        Flashcard(
            category: "Functions",
            front: "How do you add a return type to a function?",
            back: "func name() -> ReturnType {\n    return value\n}\n\nExample:\nfunc double(_ n: Int) -> Int {\n    return n * 2\n}\n\nlet result = double(5)  // result = 10"
        ),
        Flashcard(
            category: "Functions",
            front: "What is the difference between an argument label and a parameter name?",
            back: "func name(argumentLabel paramName: Type) {}\n\nThe argument label is what callers write.\nThe parameter name is what you use inside the function.\n\nExample:\nfunc drive(to destination: String) {\n    print(\"Driving to \\(destination)\")\n}\ndrive(to: \"Paris\")  // reads like English"
        ),
        Flashcard(
            category: "Functions",
            front: "How do you remove the argument label with _?",
            back: "Use _ as the argument label:\n\nfunc square(_ number: Int) -> Int {\n    return number * number\n}\n\nsquare(5)  // no label needed at call site\n\nUseful for math-style functions where the label adds no clarity."
        ),
        Flashcard(
            category: "Functions",
            front: "How do you give a function parameter a default value?",
            back: "func name(param: Type = defaultValue) {}\n\nExample:\nfunc greet(name: String = \"friend\") {\n    print(\"Hello, \\(name)!\")\n}\n\ngreet()              // \"Hello, friend!\"\ngreet(name: \"Alice\") // \"Hello, Alice!\""
        ),

        // MARK: - Optionals (6)
        Flashcard(
            category: "Optionals",
            front: "How do you declare an optional?",
            back: "var name: Type?\n\nExample:\nvar username: String? = nil\nvar age: Int? = 25\n\nAn optional can hold a value OR nil.\nNil means \"no value\" — not zero, not empty string."
        ),
        Flashcard(
            category: "Optionals",
            front: "How do you safely unwrap an optional with if let?",
            back: "if let value = optional {\n    // value is safe to use here\n}\n\nExample:\nlet input: String? = \"42\"\nif let text = input {\n    print(\"Got: \\(text)\")\n} else {\n    print(\"It was nil\")\n}"
        ),
        Flashcard(
            category: "Optionals",
            front: "How does guard let differ from if let?",
            back: "guard let exits early if nil. if let handles both branches.\n\nguard let:\nfunc process(_ input: String?) {\n    guard let text = input else { return }\n    print(text)  // continues here if not nil\n}\n\nUse guard let when nil means \"I can't continue\"."
        ),
        Flashcard(
            category: "Optionals",
            front: "What is the nil-coalescing operator ??",
            back: "optional ?? defaultValue\n\nIf the optional has a value, use it.\nIf it's nil, use the default instead.\n\nExample:\nlet name: String? = nil\nlet display = name ?? \"Guest\"\n// display = \"Guest\"\n\nShorthand for: name != nil ? name! : \"Guest\""
        ),
        Flashcard(
            category: "Optionals",
            front: "What is optional chaining ?.?",
            back: "Call methods or access properties on optionals without crashing.\nIf any link in the chain is nil, the whole expression returns nil.\n\nExample:\nlet city = user?.address?.city\n// city is String?\n// Returns nil if user or address is nil"
        ),
        Flashcard(
            category: "Optionals",
            front: "What is force unwrapping and when is it dangerous?",
            back: "Use ! to force-unwrap an optional:\nlet value = optional!\n\nExample:\nlet name: String? = \"Alice\"\nprint(name!)  // prints \"Alice\"\n\nDanger: if optional is nil at runtime, the app crashes immediately.\nOnly use ! when you are 100% certain the value exists."
        ),

        // MARK: - Collections (8)
        Flashcard(
            category: "Collections",
            front: "How do you create an array?",
            back: "let array = [value1, value2, value3]\n\nExample:\nlet fruits = [\"apple\", \"banana\", \"cherry\"]\nlet scores = [95, 87, 73, 100]\nlet empty: [Int] = []  // empty array\n\nArrays are ordered and can contain duplicates."
        ),
        Flashcard(
            category: "Collections",
            front: "How do you add an element to an array?",
            back: "array.append(newElement)\n\nExample:\nvar colors = [\"red\", \"blue\"]\ncolors.append(\"green\")\n// colors = [\"red\", \"blue\", \"green\"]\n\nNote: the array must be declared with var, not let."
        ),
        Flashcard(
            category: "Collections",
            front: "How do you create a dictionary?",
            back: "let dict = [key: value, key: value]\n\nExample:\nlet ages = [\"Alice\": 30, \"Bob\": 25]\nlet empty: [String: Int] = [:]\n\nLookup returns an optional:\nlet age = ages[\"Alice\"]  // Int? not Int"
        ),
        Flashcard(
            category: "Collections",
            front: "How do you create a Set?",
            back: "let mySet: Set<Type> = [value1, value2]\n\nExample:\nlet uniqueNumbers: Set<Int> = [1, 2, 3, 2, 1]\n// uniqueNumbers = {1, 2, 3} — no duplicates\n\nSets are unordered and have no duplicates.\nUse contains() for fast membership checks."
        ),
        Flashcard(
            category: "Collections",
            front: "How do you get the number of elements in a collection?",
            back: "collection.count\n\nExample:\nlet names = [\"Alice\", \"Bob\", \"Charlie\"]\nprint(names.count)  // 3\n\nlet scores: Set = [10, 20, 30]\nprint(scores.count)  // 3\n\nWorks on Array, Dictionary, Set, and String."
        ),
        Flashcard(
            category: "Collections",
            front: "How do you check if a collection contains a value?",
            back: "collection.contains(value)\n\nExample:\nlet fruits = [\"apple\", \"banana\"]\nfruits.contains(\"apple\")   // true\nfruits.contains(\"mango\")   // false\n\nAlso works on Set:\nlet ids: Set = [1, 2, 3]\nids.contains(2)  // true"
        ),
        Flashcard(
            category: "Collections",
            front: "How do you sort an array?",
            back: "array.sorted()  // returns a new sorted array\narray.sort()    // sorts in place (needs var)\n\nExample:\nlet nums = [3, 1, 4, 1, 5]\nlet sorted = nums.sorted()   // [1, 1, 3, 4, 5]\n\nCustom sort:\nnums.sorted { $0 > $1 }  // descending"
        ),
        Flashcard(
            category: "Collections",
            front: "How do you filter an array?",
            back: "array.filter { condition }\n\nExample:\nlet scores = [45, 72, 88, 55, 91]\nlet passing = scores.filter { $0 >= 60 }\n// passing = [72, 88, 91]\n\nReturns a new array containing only elements that match the condition."
        ),

        // MARK: - Structs & Classes (6)
        Flashcard(
            category: "Structs & Classes",
            front: "What is the main difference between struct and class?",
            back: "struct = value type (copied when assigned)\nclass  = reference type (shared when assigned)\n\nExample:\nstruct Point { var x = 0 }\nvar a = Point()\nvar b = a\nb.x = 10\n// a.x is still 0 — b is a copy\n\nIn Swift, prefer struct unless you need inheritance or shared state."
        ),
        Flashcard(
            category: "Structs & Classes",
            front: "What is the mutating keyword?",
            back: "Methods inside a struct that change its properties must be marked mutating.\n\nExample:\nstruct Counter {\n    var count = 0\n    mutating func increment() {\n        count += 1\n    }\n}\n\nClasses don't need this because they're reference types."
        ),
        Flashcard(
            category: "Structs & Classes",
            front: "How do you define a custom initializer?",
            back: "init(param: Type) {\n    self.property = param\n}\n\nExample:\nstruct Person {\n    let name: String\n    let age: Int\n    init(name: String, age: Int) {\n        self.name = name\n        self.age = age\n    }\n}\nlet p = Person(name: \"Alice\", age: 30)"
        ),
        Flashcard(
            category: "Structs & Classes",
            front: "How does class inheritance work?",
            back: "class Child: Parent {\n    // inherits Parent's properties and methods\n}\n\nExample:\nclass Animal {\n    func speak() { print(\"...\") }\n}\nclass Dog: Animal {\n    override func speak() { print(\"Woof!\") }\n}\n\nStructs cannot inherit from other structs."
        ),
        Flashcard(
            category: "Structs & Classes",
            front: "What does override mean?",
            back: "override marks a method that replaces a parent class's version.\n\nExample:\nclass Shape {\n    func area() -> Double { return 0 }\n}\nclass Circle: Shape {\n    let radius: Double\n    init(radius: Double) { self.radius = radius }\n    override func area() -> Double {\n        return .pi * radius * radius\n    }\n}\n\nXcode gives an error if you forget override when replacing a parent method."
        ),
        Flashcard(
            category: "Structs & Classes",
            front: "How do you define a static function or property?",
            back: "static func name() {}\nstatic let property = value\n\nExample:\nstruct MathHelper {\n    static let pi = 3.14159\n    static func square(_ n: Double) -> Double {\n        return n * n\n    }\n}\n\nMathHelper.pi         // no instance needed\nMathHelper.square(4)  // returns 16"
        ),

        // MARK: - Closures (4)
        Flashcard(
            category: "Closures",
            front: "What is the basic closure syntax?",
            back: "{ (params) -> ReturnType in\n    // body\n}\n\nExample:\nlet add = { (a: Int, b: Int) -> Int in\n    return a + b\n}\nadd(3, 4)  // returns 7\n\nClosures are self-contained blocks of code you can pass around."
        ),
        Flashcard(
            category: "Closures",
            front: "What is a trailing closure?",
            back: "When a closure is the last argument, you can write it outside the parentheses.\n\nRegular:\nbutton.addAction(action: { print(\"tapped\") })\n\nTrailing closure:\nbutton.addAction {\n    print(\"tapped\")\n}\n\nSwiftUI uses this constantly for view content."
        ),
        Flashcard(
            category: "Closures",
            front: "What are $0 and $1 shorthand arguments?",
            back: "In closures, $0 is the first argument, $1 the second, etc.\n\nExample:\nlet numbers = [3, 1, 4, 1, 5]\nlet doubled = numbers.map { $0 * 2 }\n// [6, 2, 8, 2, 10]\n\nlet sorted = numbers.sorted { $0 < $1 }\n// [1, 1, 3, 4, 5]\n\nUse them for short, obvious closures."
        ),
        Flashcard(
            category: "Closures",
            front: "How do map and filter work with closures?",
            back: "map transforms each element:\n[1,2,3].map { $0 * 10 }   // [10, 20, 30]\n\nfilter keeps matching elements:\n[1,2,3,4].filter { $0 > 2 }  // [3, 4]\n\nreduce combines all elements:\n[1,2,3,4].reduce(0) { $0 + $1 }  // 10\n\nThese replace many common for-loops with cleaner code."
        ),

        // MARK: - SwiftUI (6)
        Flashcard(
            category: "SwiftUI",
            front: "What does @State do?",
            back: "@State var name: Type = defaultValue\n\nStores a value that belongs to this view.\nWhen it changes, SwiftUI automatically redraws the view.\n\nExample:\n@State var count = 0\n\nButton(\"Tap\") { count += 1 }\nText(\"Count: \\(count)\")\n\nAlways declare @State as private."
        ),
        Flashcard(
            category: "SwiftUI",
            front: "What is @Binding and how do you use $?",
            back: "@Binding connects a child view to a parent's @State.\n\nParent:\n@State var isOn = false\nChildView(flag: $isOn)  // $ creates a Binding\n\nChild:\nstruct ChildView: View {\n    @Binding var flag: Bool\n    var body: some View {\n        Toggle(\"Enable\", isOn: $flag)\n    }\n}\n\nChanges in the child automatically update the parent."
        ),
        Flashcard(
            category: "SwiftUI",
            front: "How do you use NavigationStack?",
            back: "NavigationStack {\n    List { ... }\n    .navigationTitle(\"Title\")\n}\n\nTo push a new view:\nNavigationLink(\"Go to Detail\") {\n    DetailView()\n}\n\nNavigationStack manages a stack of views.\nThe back button is added automatically."
        ),
        Flashcard(
            category: "SwiftUI",
            front: "How do you present a sheet?",
            back: "@State var showSheet = false\n\nButton(\"Open\") { showSheet = true }\n.sheet(isPresented: $showSheet) {\n    Text(\"Sheet content\")\n}\n\nThe sheet slides up from the bottom.\nSet showSheet = false to dismiss it, or the user can swipe it down."
        ),
        Flashcard(
            category: "SwiftUI",
            front: "How does ForEach work in SwiftUI?",
            back: "ForEach(collection) { item in\n    // view for each item\n}\n\nExample:\nlet names = [\"Alice\", \"Bob\", \"Charlie\"]\n\nForEach(names, id: \\.self) { name in\n    Text(name)\n}\n\nIf items conform to Identifiable, skip id:\nForEach(lessons) { lesson in\n    LessonRow(lesson: lesson)\n}"
        ),
        Flashcard(
            category: "SwiftUI",
            front: "How do you display a scrollable list of items?",
            back: "List(items) { item in\n    Text(item.name)\n}\n\nExample:\nList(lessons) { lesson in\n    HStack {\n        Text(lesson.title)\n        Spacer()\n        Text(\"\\(lesson.minutes) min\")\n    }\n}\n\nList automatically adds scroll behavior, separators, and row insets."
        ),
    ]
}
