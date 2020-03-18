import Cocoa

let passingGrade = 50
let simoGrade = 45
let cinziaGrade = 89

print(simoGrade, cinziaGrade, "meow")

func getHighestGrade(grades: Int...) -> Int {
    grades.max() ?? 0
}

getHighestGrade()
getHighestGrade(grades: simoGrade, cinziaGrade)
// getHighestGrade(grades: [40,50,60]) NO!

var count = 50

func incrementAndPrint(_ value: inout Int){
    value+=1
    print(value)
}

incrementAndPrint(&count)

// CHALLENGES
func multiply(number: Int, by multiplier: Int) -> Int {
    return number * multiplier
}

func multiply(number1: Int, number2: Int, number3: Int) -> Int{
    return number1 * number2 * number3
}

func multiply(number: Double, by multiplier: Double) -> Double {
    return number * multiplier
}

multiply(number1: 3, number2: 4, number3: 2)
multiply(number: 5.2, by: 2.3)
multiply(number: 5, by: 5)

// functions as parameters
func add(number1: Int, number2: Int) -> Int{
    number1 + number2
}
var function = add
function(4,3)

func subtract(number1: Int, number2: Int) -> Int{
    number1 - number2
}

function = subtract
function(4,3)

typealias Operate = (Int,Int) -> Int
func printResult(_ operate: Operate, _ a: Int, _ b: Int ){
    let result = operate(a,b)
    print(result)
}
printResult(add, 5, 10)
printResult(subtract, 5, 10)
printResult(*, 5, 10)
