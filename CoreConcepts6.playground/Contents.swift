import Cocoa

class Actor {
    let name: String
    var filmography: [String] = []
    
    init(name: String, filmography: [String]){
        self.name = name
        self.filmography=filmography
    }
    
    func signOnForSequel(franchiseName: String){
        filmography.append("Upcoming \(franchiseName) sequel")
    }
}

var gotgStar = Actor(name: "Zoe Saldana", filmography: ["Guardiani della galassia"])
gotgStar.filmography.append("Avatar")
var starTrekStar = gotgStar
starTrekStar.filmography.append("Star Trek")
var avatarStar = starTrekStar
for franchiseName in avatarStar.filmography{
    avatarStar.signOnForSequel(franchiseName: franchiseName)
}
print(avatarStar.filmography)
print(starTrekStar.filmography)


// Challenges
print("\nChallenge 1:")
class Student {
    let name: String
    var grade: Int
    var pet: String?
    init(name: String, grade: Int, pet: String? = nil){
        self.name = name
        self.grade = grade
        self.pet = pet
    }
    
    func getPassStatus(lowestPass: Int = 50) -> Bool{
        grade >= lowestPass
    }
    
    func earnExtraCredit(){
        grade += 10
    }
}
