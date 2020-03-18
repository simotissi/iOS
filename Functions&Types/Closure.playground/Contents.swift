import Cocoa

/*
 CLOSURE
 { (a: Int, b: Int) -> Int in
    a * b
 }
 
 FUNCTION
 func multiply(a: Int, b: Int) -> Int{
    a * b
 }
 **/

typealias Operate = (Int, Int) -> Int
func add(a: Int, b: Int) -> Int {
    a + b
}

func printResult(_ operate: Operate, _ a: Int, _ b: Int){
    print(operate(a,b))
}

var operate = add
var addClosure = { (a:Int, b: Int) -> Int in
    return a + b
}

add(a: 7, b: 3)
operate(7, 3)
addClosure(7,3)

printResult(add, 4, 5)
printResult(operate, 4, 5)
printResult(addClosure, 4, 5)
printResult(+, 4, 5)

printResult(
    { (a, b) -> Int in
        a * b + 100
}, 3, 10)

// CHALLENGES
func calculateFullName(firstName: String, lastName: String?) -> String{
    firstName + " " + (lastName ?? "")
}

let fullnameClosure = { (firstName: String, lastName: String?) -> String in
    firstName + " " + (lastName ?? "")
}
let simoName = calculateFullName(firstName: "Simone", lastName: nil)
calculateFullName(firstName: "Simone", lastName: "Tissi")
fullnameClosure("Simone", "Tissi")
fullnameClosure("Simone", nil)

// CLOURE OPTIONS

let longClosure = { (a: Int, b: Int) -> Int in
    a * b
}

let noParameterTypes: Operate = { (a, b) -> Int in
    a * b
}

let noReturnType: Operate = { (a, b) in
    a * b
}

let shortClosure: Operate = { $0 * $1 } // not raccomanded

longClosure(4,3)
noParameterTypes(4,3)
noReturnType(4,3)
shortClosure(4,3)

let voidClosure: () -> Void = {
    print("Hey Swift!")
}
voidClosure()

func printResult(_ a: Int, _ b: Int, _ operate: Operate){
    print(operate(a,b))
}

printResult(19, 2, {$0 * $1 + 10})

printResult(19, 2) { $0 * $1 + 10}

// CHALLENGES
let copyLines = { (offense: String, repeatCount: Int) -> Void in
    print(String(repeating: "I must not \(offense).", count: repeatCount))
}

let copyLines_2: (String, Int) -> Void = { offense, repeatCount -> Void in
    print(String(repeating: "I must not \(offense).", count: repeatCount))
}

let copyLines_3: (String, Int) -> Void = { offense, repeatCount in
    print(String(repeating: "I must not \(offense).", count: repeatCount))
}

let copyLines_4: (String, Int) -> Void = {
    print(String(repeating: "I must not \($0).", count: $1))
}

copyLines("tell lies", 5)
copyLines_2("tell lies", 5)
copyLines_3("tell lies", 5)
copyLines_4("tell lies", 5)

