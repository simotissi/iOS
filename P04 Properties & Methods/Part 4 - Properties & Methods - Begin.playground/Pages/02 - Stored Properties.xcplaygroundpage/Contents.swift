//: [⇐ Previous: 01 - Introduction](@previous)
//: ## Episode 02: Stored Properties
struct Wizard {
  static var magicIng = [
    "Polisucco",
    "Cannuccia",
    "Cazzo di gomma"
    ] {
    didSet{
      print("Magical ing updated: \(magicIng)")
    }
  }
  var firstName: String {
    willSet{
      print(firstName + " will be set to " + newValue)
    }
    didSet{
      if firstName.contains(" "){
        print("No spaces allowed! \(firstName) is not a firstName. Reverting to \(oldValue)")
        firstName = oldValue
      }
    }
  }
  var lastName: String
  
  var fullName: String{
    get {return "\(firstName) \(lastName)"}
    set {
      let nameSubstrings = newValue.split(separator: " ")
      guard nameSubstrings.count >= 2 else {
        print("\(newValue) is not a full name")
        return
      }
      let nameString = nameSubstrings.map(String.init)
      firstName = nameString.first!
      lastName = nameString.last!
    }
  }
  lazy var magicCreature = ""
}

var wizard = Wizard(firstName: "Gandalf", lastName: "Greyjoy")
wizard.firstName = "Hermione"
wizard.lastName = "Granger"
wizard

wizard.firstName = "Mago Merlino"

wizard.fullName = "Severus Piton"
//: [⇒ Next: 03 - Computed Properties](@next)
