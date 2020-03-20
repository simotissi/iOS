//: [⇐ Previous: 04 - Switch Statements](@previous)
//: ## Episode 05: More Switch Statements

//: Switching on values
func getDesc(for number: Int)->String{
  switch number {
  case 0:
    return "Zero"
  case 1...9:
    return "Between 1 and 9"
  case let negativeNumber where negativeNumber < 0:
    return "Negative number"
  case _ where number > .max / 2:
    return "Very large!"
  default:
    return "No Desc"
  }
}

getDesc(for: Int.max)
getDesc(for: 0)
getDesc(for: 7)
getDesc(for: -15)
getDesc(for: 15)



//: Switching on expressions
let numb = Int.max
let numbIsEven: Bool
switch numb % 2 {
case 0:
  numbIsEven = true
default:
  numbIsEven = false
}



//: Switching on multiple values
func pointCategory(coordinates: (Double,Double)) -> String {
  switch coordinates {
  case (0, 0):
    return "Origin"
  case (let x, 0):
    return "x: \(x) and y: 0.0"
  case (0, let y):
    return "x: 0.0 and y: \(y)"
  case _ where coordinates.0 == coordinates.1:
    return "y = x"
  case let (x, y) where y == x * x:
    return "y = x ^2"
  case let (x, y):
    return "x: \(x) and y: \(y)"
  }
}

pointCategory(coordinates: (2,4))
pointCategory(coordinates: (2,2))
pointCategory(coordinates: (0,0))
pointCategory(coordinates: (50,0))
pointCategory(coordinates: (0,50))
pointCategory(coordinates: (5,5))


//: [⇒ Next: 06 - Challenge - Switch Statements](@next)

