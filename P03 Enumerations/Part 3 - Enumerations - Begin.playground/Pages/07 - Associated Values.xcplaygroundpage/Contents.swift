//: [⇐ Previous: 06 - Challenge - Switch Statements](@previous)
//: ## Episode 07: Enumerations with Associated Values
enum TwoDimPoint{
  case origin
  case onXAxis(Double)
  case onYAxis(Double)
  case noZero(x: Double, y: Double)
}

let coordinates = (1.0, 3.0)
let twoDimPoint: TwoDimPoint

switch coordinates {
  case (0,0):
    twoDimPoint = .origin
  case (_, 0):
    twoDimPoint = .onXAxis(coordinates.0)
  case (0, _):
    twoDimPoint = .onYAxis(coordinates.0)
  default:
    twoDimPoint = .noZero(x: coordinates.0, y: coordinates.1)
}

//: [⇒ Next: 08 - Conclusion](@next)
