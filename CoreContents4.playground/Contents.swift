import Cocoa

func firstFunc() -> String{
    return "Hello World!"
}
func firstFunc2(){
    print("Hello World!")
}
firstFunc()
firstFunc2()


// With parameters
let passingGrade = 50
let simoGrade = 49
let cinziaGrade = 99
let simoPassed = simoGrade >= passingGrade
let cinziaPassed = cinziaGrade >= passingGrade

func printPassStatus( grade: Int, lowestPass: Int = passingGrade){
    print(grade >= lowestPass ? "You passed!" : "Keep studying")
}

printPassStatus(grade: simoGrade)
printPassStatus(grade: simoGrade, lowestPass: 40)


typealias  Student = (name: String, grade: Int, pet: String?)
let pippo: Student = (name: "Pippo", grade: 59, pet: nil)
let luca: Student = (name: "Luca", grade: 88, pet: "Cat")
func orderPetCollar(for student: Student){
    guard let pet = student.pet else { return }
    print("One custom collar for \(student.name)'s pet, \(pet)!")
}

orderPetCollar(for: pippo)
orderPetCollar(for: luca)

// CHALLENGE
print("\nChallenge 1:")
func printFullName(_ firstName: String, _ lastName: String){
    print("\(firstName) \(lastName)")
}
printFullName("Simone", "Tissi")

print("\nChallenge 2:")
func calculateFullName(_ firstName: String, _ lastName: String) -> String{
    return "\(firstName) \(lastName)"
}
let myName = calculateFullName("Simone", "Tissi")
print(myName)
