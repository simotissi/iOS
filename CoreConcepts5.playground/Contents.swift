import Cocoa

// typealias Student = (name: String, grade: Int, pet: String?)
// is equal to:

struct Student {
    let name: String
    var grade: Int
    var pet: String?
    
    func isPassing(lowestPass: Int = 50) -> Bool{
        return grade >= lowestPass
    }
    mutating func earnExtraCredit(){
        grade += 10
    }
}

var simo = Student(name: "Simone", grade: 44, pet: "Pof")
var cinzia = Student(name: "Cinzia", grade: 76, pet: "Kronk")
var marco = Student(name: "Marco", grade: 45, pet: nil)

simo.isPassing()
simo.earnExtraCredit()
simo.isPassing()

var evilMarco = marco
evilMarco.grade = 100
evilMarco.pet = "Mustacchio"
print(marco)
print(evilMarco)

//CHALLENGES
print("\nChallenge 1:")
struct Student2 {
    let firstName: String
    let lastName: String
    var grade: Int
}

struct Classroom {
    let subject: String
    var students: [Student2]
    
    func getHighestGrade() -> Int? {
        var grades: [Int] = []
        for student in students{
            grades.append(student.grade)
        }
        return grades.max()
    }
}

print("\nChallenge 2:")

let myClass = Classroom(subject: "Math",
                        students: [
                            Student2(firstName: "Simone", lastName: "Tissi", grade: 80),
                            Student2(firstName: "Cinzia", lastName: "Feltrin", grade: 90),
                            Student2(firstName: "Marco", lastName: "Magra", grade: 100)
                        ])
myClass.getHighestGrade()
