//: [⇐ Previous: 02 - Enumerations](@previous)
//: ## Episode 03: Challenge - Enumerations

import SwiftUI

/*:
 ## Challenge 1
 Another handy use case for an enumeration is storing a specific set of strings you need to use!
 - Create a "Suit" enumeration with a `String` raw value type
 - Make a case for each string used to create an `Image` in the code below. (Watch for misspellings!)
 - Replace each use of a string with the raw value of an enumeration case
*/

enum Suit: String{
  case heart = "suit.heart.fill"
  case club = "suit.club.fill"
  case spade = "suit.spade.fill"
  case diamond = "suit.diamond.fill"
}

// --------------------------------------
let heart = Image(systemName: Suit.heart.rawValue).resizable()
let club = Image(systemName: Suit.club.rawValue).resizable()
let spade = Image(systemName: Suit.spade.rawValue).resizable()
let diamond = Image(systemName: Suit.diamond.rawValue).resizable()
// --------------------------------------


/*:
 ## Challenge 2
 Integer raw values don’t have to be in an incremental order! Coins are a good use case.
 
 - Create an enumeration called "Coin" and add cases for different types of coins.
 - Create an array called `coinPurse` that contains coins. Add an assortment of pennies, nickels, dimes, and quarters (or whatever coins you used!) to it.
*/

enum Coin: Double {
  case penny = 0.01
  case nickel = 0.05
  case dime = 0.10
  case quarter = 0.25
}

let coinPurse: [Coin] = [.penny, .nickel, .dime, .quarter, .quarter, .dime]
/*:
 ## Bonus Challenge!
 Try using `reduce` to figure out how much money is in your coin purse.
 Remember to use the `rawValue` property!
*/
let total = coinPurse.reduce(0.0) { (result, coin) -> Double in
  result + coin.rawValue
}




//: [⇒ Next: 04 - Switch Statements](@next)
