import Cocoa

let emptyDic: [String: Int] = [:]

var petName = [
    "Ron": "🐀 Rat",
    "Goku": "☁️ Cloud",
    "Simone": "🍁 Weed",
    "Thor": "🔨 Hammer"
]
print(petName)
petName.updateValue("🦮 Mango", forKey: "Chris")
petName.updateValue("🐈 Pof", forKey: "Ron")
petName["Simone"] = "🐈 Kronk"
print(petName)

for (person, pet) in petName{
    print("\(person) has a \(pet)")
}

// THOSE TWO LOOPS ARE EQUALS
for (_, pet) in petName{
    print(pet)
}
for pet in petName.values{
    print(pet)
}

// THOSE TWO LOOPS ARE EQUALS
for (name, _) in petName{
    print(name)
}
for name in petName.keys{
    print(name)
}

// CHALLANGES
// 1
print("\n----Challenge 1----")
var simone = [
    "name": "Simone",
    "profession": "iOS Dev",
    "country": "Italy",
    "city": "Udine"
]
print(simone)

// 2
print("\n----Challenge 2----")
simone["country"] = "USA"
simone["city"] = "Cleveland"
simone.updateValue("Ohio", forKey: "state") // also: simone["state"] = "Ohio"
print(simone)

// 3
print("\n----Challenge 3----")
simone["city"] = nil
simone.removeValue(forKey: "state")
print(simone)

// 4
print("\n----Challenge 4----")
for (key, value) in simone{
    print("\(key): \(value)")
}
