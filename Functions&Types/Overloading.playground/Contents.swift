import Cocoa

let passinGrade = 50
let simoGrade = 80
let marcoGrade = 60
let cinziaGrade = 45

//  func getPassStatus(grade: Int)-> Bool {
//      grade >= passinGrade
//  }

//  func getPassStatus(grade: Int, lowestPass: Int)-> Bool {
//     grade >= lowestPass
//  }

// Use one function with default value, this is not overloading:
func getPassStatus(grade: Int, lowestPass: Int = passinGrade)-> Bool {
    grade >= lowestPass
}


