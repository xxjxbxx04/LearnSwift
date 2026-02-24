import Foundation

struct CheatSheetItem: Identifiable {
    let id = UUID()
    let label: String
    let syntax: String
    let note: String?

    init(label: String, syntax: String, note: String? = nil) {
        self.label = label
        self.syntax = syntax
        self.note = note
    }
}

struct CheatSheetSection: Identifiable {
    let id: UUID
    let title: String
    let emoji: String
    let items: [CheatSheetItem]

    init(id: UUID = UUID(), title: String, emoji: String, items: [CheatSheetItem]) {
        self.id = id
        self.title = title
        self.emoji = emoji
        self.items = items
    }
}

struct CheatSheetData {
    static let sections: [CheatSheetSection] = [

        CheatSheetSection(title: "Variables & Constants", emoji: "📦", items: [
            CheatSheetItem(label: "Constant (can't change)", syntax: "let name = \"Alice\"", note: "Use let by default."),
            CheatSheetItem(label: "Variable (can change)", syntax: "var score = 0"),
            CheatSheetItem(label: "Explicit type", syntax: "var age: Int = 25"),
            CheatSheetItem(label: "String interpolation", syntax: "\"Hello, \\(name)!\""),
            CheatSheetItem(label: "Multi-line string", syntax: "\"\"\"\nLine one\nLine two\n\"\"\""),
        ]),

        CheatSheetSection(title: "Data Types", emoji: "🔢", items: [
            CheatSheetItem(label: "Integer", syntax: "let count: Int = 10"),
            CheatSheetItem(label: "Decimal number", syntax: "let price: Double = 9.99"),
            CheatSheetItem(label: "True / False", syntax: "let isOn: Bool = true"),
            CheatSheetItem(label: "Text", syntax: "let greeting: String = \"Hi\""),
            CheatSheetItem(label: "Optional (may be nil)", syntax: "var username: String? = nil", note: "? means the value might be missing."),
        ]),

        CheatSheetSection(title: "Optionals", emoji: "❓", items: [
            CheatSheetItem(label: "Optional binding (if let)", syntax: "if let name = username {\n    print(name)\n}"),
            CheatSheetItem(label: "Guard let (exit early)", syntax: "guard let name = username else { return }"),
            CheatSheetItem(label: "Nil-coalescing (default value)", syntax: "let display = username ?? \"Guest\""),
            CheatSheetItem(label: "Optional chaining", syntax: "let city = user?.address?.city"),
            CheatSheetItem(label: "Force unwrap (risky!)", syntax: "let name = username!", note: "Crashes if nil. Avoid unless certain it's not nil."),
        ]),

        CheatSheetSection(title: "Control Flow", emoji: "🚦", items: [
            CheatSheetItem(label: "If / else if / else", syntax: "if score > 90 {\n    print(\"A\")\n} else if score > 70 {\n    print(\"B\")\n} else {\n    print(\"C\")\n}"),
            CheatSheetItem(label: "Switch statement", syntax: "switch day {\ncase \"Monday\":\n    print(\"Start\")\ncase \"Friday\":\n    print(\"End\")\ndefault:\n    print(\"Midweek\")\n}"),
            CheatSheetItem(label: "Ternary operator", syntax: "let label = score >= 60 ? \"Pass\" : \"Fail\""),
        ]),

        CheatSheetSection(title: "Loops", emoji: "🔄", items: [
            CheatSheetItem(label: "For-in loop", syntax: "for i in 1...5 {\n    print(i)\n}"),
            CheatSheetItem(label: "For-in over array", syntax: "for name in names {\n    print(name)\n}"),
            CheatSheetItem(label: "For with index", syntax: "for (index, name) in names.enumerated() {\n    print(\"\\(index): \\(name)\")\n}"),
            CheatSheetItem(label: "While loop", syntax: "while count < 10 {\n    count += 1\n}"),
            CheatSheetItem(label: "Range types", syntax: "1...5  // 1 through 5 (inclusive)\n1..<5  // 1 through 4 (exclusive)", note: "... is closed range, ..< is half-open."),
        ]),

        CheatSheetSection(title: "Functions", emoji: "⚙️", items: [
            CheatSheetItem(label: "Basic function", syntax: "func greet() {\n    print(\"Hello!\")\n}"),
            CheatSheetItem(label: "Function with parameter", syntax: "func greet(name: String) {\n    print(\"Hello, \\(name)!\")\n}"),
            CheatSheetItem(label: "Function with return value", syntax: "func add(_ a: Int, _ b: Int) -> Int {\n    return a + b\n}"),
            CheatSheetItem(label: "Argument label vs param name", syntax: "func drive(to destination: String) {\n    print(\"Going to \\(destination)\")\n}\ndrive(to: \"Paris\")"),
            CheatSheetItem(label: "Default parameter", syntax: "func greet(name: String = \"friend\") {\n    print(\"Hello, \\(name)!\")\n}"),
        ]),

        CheatSheetSection(title: "Collections", emoji: "📚", items: [
            CheatSheetItem(label: "Array — create", syntax: "var fruits = [\"Apple\", \"Banana\", \"Cherry\"]"),
            CheatSheetItem(label: "Array — add item", syntax: "fruits.append(\"Mango\")"),
            CheatSheetItem(label: "Array — access by index", syntax: "let first = fruits[0]", note: "First element is index 0."),
            CheatSheetItem(label: "Dictionary — create", syntax: "var ages = [\"Alice\": 30, \"Bob\": 25]"),
            CheatSheetItem(label: "Dictionary — access", syntax: "let aliceAge = ages[\"Alice\"]  // Optional"),
            CheatSheetItem(label: "Set — create", syntax: "var colors: Set = [\"Red\", \"Blue\", \"Red\"]\n// Duplicates removed automatically"),
            CheatSheetItem(label: "filter / map / reduce", syntax: "let evens = [1,2,3,4].filter { $0 % 2 == 0 }\nlet doubled = [1,2,3].map { $0 * 2 }\nlet sum = [1,2,3].reduce(0) { $0 + $1 }"),
        ]),

        CheatSheetSection(title: "Structs & Classes", emoji: "🏛️", items: [
            CheatSheetItem(label: "Struct (value type)", syntax: "struct Person {\n    var name: String\n    var age: Int\n}"),
            CheatSheetItem(label: "Create struct instance", syntax: "let alice = Person(name: \"Alice\", age: 30)"),
            CheatSheetItem(label: "Struct method (mutating)", syntax: "mutating func birthday() {\n    age += 1\n}", note: "Need 'mutating' to modify properties in a struct."),
            CheatSheetItem(label: "Class (reference type)", syntax: "class Car {\n    var speed = 0\n    func accelerate() { speed += 10 }\n}"),
            CheatSheetItem(label: "Computed property", syntax: "var fullName: String {\n    return \"\\(firstName) \\(lastName)\"\n}"),
        ]),

        CheatSheetSection(title: "Enumerations", emoji: "📋", items: [
            CheatSheetItem(label: "Basic enum", syntax: "enum Direction {\n    case north, south, east, west\n}"),
            CheatSheetItem(label: "Enum with raw value", syntax: "enum Planet: Int {\n    case mercury = 1\n    case venus = 2\n}"),
            CheatSheetItem(label: "Using an enum", syntax: "let heading = Direction.north"),
            CheatSheetItem(label: "Switch over enum", syntax: "switch heading {\ncase .north: print(\"Go north\")\ncase .south: print(\"Go south\")\ndefault: print(\"Other\")\n}"),
        ]),

        CheatSheetSection(title: "SwiftUI Basics", emoji: "📱", items: [
            CheatSheetItem(label: "Simple View", syntax: "struct MyView: View {\n    var body: some View {\n        Text(\"Hello!\")\n    }\n}"),
            CheatSheetItem(label: "@State (local state)", syntax: "@State private var count = 0"),
            CheatSheetItem(label: "Button", syntax: "Button(\"Tap me\") {\n    count += 1\n}"),
            CheatSheetItem(label: "VStack / HStack / ZStack", syntax: "VStack {\n    Text(\"Top\")\n    Text(\"Bottom\")\n}"),
            CheatSheetItem(label: "Binding (pass state down)", syntax: "// Parent:\n@State private var isOn = false\nChildView(flag: $isOn)\n\n// Child:\n@Binding var flag: Bool"),
            CheatSheetItem(label: "List", syntax: "List(items) { item in\n    Text(item.name)\n}", note: "Items must conform to Identifiable."),
            CheatSheetItem(label: "NavigationStack + Link", syntax: "NavigationStack {\n    NavigationLink(\"Go\", destination: DetailView())\n}"),
        ]),
    ]
}
