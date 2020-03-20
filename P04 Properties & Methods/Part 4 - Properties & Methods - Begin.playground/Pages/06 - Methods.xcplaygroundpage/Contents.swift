//: [⇐ Previous: 05 - Challenge: Properties](@previous)
//: ## Episode 06: Methods
enum WeekDay: CaseIterable{
  case lun, mar, mer, gio, ven, sab
  
  func advance(dayCount:UInt){
    let indexOfDay = WeekDay.allCases.firstIndex(of: self)!
    let indexOfAdvancedDay = indexOfDay + Int(dayCount)
  }
}
WeekDay.allCases

var weekday: WeekDay = .gio


//: [⇒ Next: 07 - Challenge - Methods](@next)
