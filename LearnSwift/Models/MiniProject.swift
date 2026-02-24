import Foundation

struct ProjectStep: Identifiable {
    let id = UUID()
    let number: Int
    let title: String
    let explanation: String
    let code: String?
    let note: String?

    init(number: Int, title: String, explanation: String, code: String? = nil, note: String? = nil) {
        self.number = number
        self.title = title
        self.explanation = explanation
        self.code = code
        self.note = note
    }
}

struct MiniProject: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let description: String
    let difficulty: String
    let estimatedMinutes: Int
    let whatYoullLearn: [String]
    let steps: [ProjectStep]
}

struct MiniProjectData {
    static let all: [MiniProject] = [

        MiniProject(
            emoji: "👋",
            title: "Hello, Swift!",
            description: "Your very first Swift program — print messages, declare variables, and greet the user.",
            difficulty: "Beginner",
            estimatedMinutes: 10,
            whatYoullLearn: [
                "How to print text to the console",
                "How to declare constants and variables",
                "How to use string interpolation",
            ],
            steps: [
                ProjectStep(
                    number: 1,
                    title: "Print a greeting",
                    explanation: "The print() function outputs text to the console. This is the first thing every programmer learns.",
                    code: "print(\"Hello, World!\")\nprint(\"Welcome to Swift!\")",
                    note: "In a Playground, output appears in the panel on the right."
                ),
                ProjectStep(
                    number: 2,
                    title: "Store your name in a constant",
                    explanation: "Use let to create a constant — a name for a value that won't change.",
                    code: "let myName = \"Alice\"\nprint(\"My name is \\(myName)\")",
                    note: "The \\(myName) inside quotes is called string interpolation — it inserts the variable's value."
                ),
                ProjectStep(
                    number: 3,
                    title: "Store your age in a variable",
                    explanation: "Use var when the value needs to change. Age increases every year!",
                    code: "var myAge = 22\nprint(\"I am \\(myAge) years old.\")\nmyAge += 1\nprint(\"Next year I'll be \\(myAge).\")"
                ),
                ProjectStep(
                    number: 4,
                    title: "Put it all together",
                    explanation: "Combine everything into a greeting that introduces you.",
                    code: "let name = \"Alice\"\nlet city = \"New York\"\nvar age = 22\n\nprint(\"Hi! I'm \\(name) from \\(city).\")\nprint(\"I am \\(age) years old.\")\nprint(\"Next year I'll be \\(age + 1).\")"
                ),
            ]
        ),

        MiniProject(
            emoji: "🌡️",
            title: "Temperature Converter",
            description: "Build a utility that converts temperatures between Celsius and Fahrenheit using functions.",
            difficulty: "Beginner",
            estimatedMinutes: 15,
            whatYoullLearn: [
                "How to write functions that take parameters and return values",
                "How to perform arithmetic in Swift",
                "How to round and format numbers",
            ],
            steps: [
                ProjectStep(
                    number: 1,
                    title: "Write a Celsius-to-Fahrenheit function",
                    explanation: "A function takes input, does something with it, and returns a result. The formula is: F = C × 9/5 + 32.",
                    code: "func celsiusToFahrenheit(_ celsius: Double) -> Double {\n    return celsius * 9 / 5 + 32\n}",
                    note: "The underscore _ before celsius means callers don't need to write the label: celsiusToFahrenheit(100)"
                ),
                ProjectStep(
                    number: 2,
                    title: "Write a Fahrenheit-to-Celsius function",
                    explanation: "The reverse formula is: C = (F - 32) × 5/9.",
                    code: "func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {\n    return (fahrenheit - 32) * 5 / 9\n}"
                ),
                ProjectStep(
                    number: 3,
                    title: "Test your functions",
                    explanation: "Call both functions and print the results. Water boils at 100°C = 212°F.",
                    code: "let boilingF = celsiusToFahrenheit(100)\nprint(\"100°C = \\(boilingF)°F\")  // 212\n\nlet bodyC = fahrenheitToCelsius(98.6)\nprint(\"98.6°F = \\(bodyC)°C\")  // 37.0"
                ),
                ProjectStep(
                    number: 4,
                    title: "Round the result to one decimal place",
                    explanation: "Real apps don't show 14 decimal places. Use Swift's rounded() or a format string.",
                    code: "let rounded = (bodyC * 10).rounded() / 10\nprint(\"98.6°F = \\(rounded)°C\")\n\n// Or use String(format:)\nlet formatted = String(format: \"%.1f\", bodyC)\nprint(\"98.6°F = \\(formatted)°C\")",
                    note: "String(format: \"%.1f\", value) formats to 1 decimal place — very handy for displaying numbers."
                ),
            ]
        ),

        MiniProject(
            emoji: "📊",
            title: "Grade Calculator",
            description: "Calculate a student's average grade and letter grade from an array of scores.",
            difficulty: "Beginner",
            estimatedMinutes: 15,
            whatYoullLearn: [
                "How to work with arrays of numbers",
                "How to use loops and reduce to sum values",
                "How to use if/else to assign letter grades",
            ],
            steps: [
                ProjectStep(
                    number: 1,
                    title: "Create an array of test scores",
                    explanation: "An array stores multiple values in an ordered list. Use square brackets.",
                    code: "let scores = [88, 92, 75, 95, 84]\nprint(\"Scores: \\(scores)\")\nprint(\"Number of scores: \\(scores.count)\")"
                ),
                ProjectStep(
                    number: 2,
                    title: "Calculate the average",
                    explanation: "Use reduce to add all scores together, then divide by the count.",
                    code: "let total = scores.reduce(0, +)\nlet average = Double(total) / Double(scores.count)\nprint(\"Total: \\(total)\")\nprint(\"Average: \\(average)\")",
                    note: "reduce(0, +) starts at 0 and adds each element. Double() converts Int to a decimal so division works correctly."
                ),
                ProjectStep(
                    number: 3,
                    title: "Assign a letter grade",
                    explanation: "Write a function that takes the average and returns A, B, C, D, or F.",
                    code: "func letterGrade(for average: Double) -> String {\n    switch average {\n    case 90...100: return \"A\"\n    case 80..<90:  return \"B\"\n    case 70..<80:  return \"C\"\n    case 60..<70:  return \"D\"\n    default:       return \"F\"\n    }\n}"
                ),
                ProjectStep(
                    number: 4,
                    title: "Print the final report",
                    explanation: "Put it all together and print a nicely formatted report.",
                    code: "let scores = [88, 92, 75, 95, 84]\nlet total = scores.reduce(0, +)\nlet average = Double(total) / Double(scores.count)\nlet grade = letterGrade(for: average)\n\nprint(\"--- Grade Report ---\")\nprint(\"Scores: \\(scores)\")\nprint(\"Average: \\(String(format: \"%.1f\", average))\")\nprint(\"Letter Grade: \\(grade)\")"
                ),
            ]
        ),

        MiniProject(
            emoji: "🛒",
            title: "Shopping List",
            description: "Build a text-based shopping list app that can add, remove, and display items.",
            difficulty: "Intermediate",
            estimatedMinutes: 20,
            whatYoullLearn: [
                "How to add and remove items from an array",
                "How to use loops to display a list",
                "How to write multiple functions that work together",
                "How to handle edge cases (empty list, item not found)",
            ],
            steps: [
                ProjectStep(
                    number: 1,
                    title: "Create the shopping list array",
                    explanation: "Start with a variable array so you can add and remove items.",
                    code: "var shoppingList: [String] = []\nprint(\"Shopping list created. Currently empty.\")"
                ),
                ProjectStep(
                    number: 2,
                    title: "Write an addItem function",
                    explanation: "Functions keep your code organized. This one adds an item to the list.",
                    code: "func addItem(_ item: String) {\n    shoppingList.append(item)\n    print(\"✅ Added: \\(item)\")\n}\n\naddItem(\"Milk\")\naddItem(\"Eggs\")\naddItem(\"Bread\")"
                ),
                ProjectStep(
                    number: 3,
                    title: "Write a displayList function",
                    explanation: "Show all items with their position number. Handle the empty list case.",
                    code: "func displayList() {\n    if shoppingList.isEmpty {\n        print(\"Your list is empty!\")\n        return\n    }\n    print(\"--- Shopping List ---\")\n    for (index, item) in shoppingList.enumerated() {\n        print(\"\\(index + 1). \\(item)\")\n    }\n}\n\ndisplayList()"
                ),
                ProjectStep(
                    number: 4,
                    title: "Write a removeItem function",
                    explanation: "Find the item by name and remove it. If not found, say so.",
                    code: "func removeItem(_ item: String) {\n    if let index = shoppingList.firstIndex(of: item) {\n        shoppingList.remove(at: index)\n        print(\"❌ Removed: \\(item)\")\n    } else {\n        print(\"⚠️ '\\(item)' not found in list.\")\n    }\n}\n\nremoveItem(\"Eggs\")\ndisplayList()",
                    note: "firstIndex(of:) returns an Optional index. We use if let to safely unwrap it."
                ),
            ]
        ),

        MiniProject(
            emoji: "🎲",
            title: "Number Guessing Game",
            description: "A complete guessing game where the player tries to guess a random number with hints.",
            difficulty: "Intermediate",
            estimatedMinutes: 25,
            whatYoullLearn: [
                "How to generate random numbers",
                "How to use while loops for repeated attempts",
                "How to compare values and give feedback",
                "How to track state (number of guesses)",
            ],
            steps: [
                ProjectStep(
                    number: 1,
                    title: "Generate a secret random number",
                    explanation: "Swift has built-in random number generation. Pick a number between 1 and 100.",
                    code: "let secret = Int.random(in: 1...100)\nprint(\"Secret number generated! (Between 1 and 100)\")",
                    note: "In a real game, you'd never print the secret number! This is just to test it works."
                ),
                ProjectStep(
                    number: 2,
                    title: "Write the guess-checking logic",
                    explanation: "A function that compares the guess to the secret and returns a hint.",
                    code: "func checkGuess(_ guess: Int, against secret: Int) -> String {\n    if guess < secret {\n        return \"Too low! Try higher.\"\n    } else if guess > secret {\n        return \"Too high! Try lower.\"\n    } else {\n        return \"🎉 Correct!\"\n    }\n}"
                ),
                ProjectStep(
                    number: 3,
                    title: "Build the game loop",
                    explanation: "Use a while loop to keep asking for guesses until the player wins.",
                    code: "var guesses = 0\nvar hasWon = false\n\nwhile !hasWon {\n    // In a real app, you'd read user input.\n    // In a Playground, we simulate guesses:\n    let guess = Int.random(in: 1...100)  // simulate a guess\n    guesses += 1\n    \n    let result = checkGuess(guess, against: secret)\n    print(\"Guess #\\(guesses): \\(guess) — \\(result)\")\n    \n    if guess == secret {\n        hasWon = true\n    }\n}"
                ),
                ProjectStep(
                    number: 4,
                    title: "Show the final score",
                    explanation: "Tell the player how many guesses it took and rate their performance.",
                    code: "print(\"You guessed \\(secret) in \\(guesses) guesses!\")\n\nswitch guesses {\ncase 1:\n    print(\"🏆 Incredible! First try!\")\ncase 2...5:\n    print(\"⭐ Great job! Very few guesses.\")\ncase 6...10:\n    print(\"👍 Not bad! You got it.\")\ndefault:\n    print(\"😅 Keep practicing — you'll get faster!\")\n}"
                ),
            ]
        ),
    ]
}
