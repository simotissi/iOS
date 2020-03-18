import Cocoa

var someSet: Set<Int> = [1,2,3,1]
// let someArray: Array<Int>
// let someDic: Dictionary<String, Int>
someSet.contains(1)
someSet.contains(99)
someSet.insert(5)
let removedElement = someSet.remove(3)
let nilElement = someSet.remove(88)
print(someSet)

var anotherSet: Set<Int> = [5,3,4]

let intersacton = someSet.intersection(anotherSet)
let difference = someSet.symmetricDifference(anotherSet)
let union = someSet.union(anotherSet)

// Use form... to mutate the original set
someSet.formUnion(anotherSet)
print(someSet)
print(anotherSet)


// CHALLENGES
// 0
print("\nChallenge 0:")
// Two ways to create set:
var pets = Set<String>() // empty set, populate them with pets.insert(someValue)
pets.insert("Mango")
pets.insert("Tiger")
pets.insert("Toothless")
pets.insert("Owl")
print(pets)
var pets2: Set<String> = ["Owl","Hammer","Luggage","Toothless","Flying Nimbus"] // not empty set
print(pets2)

// 1
print("\nChallenge 1:")
print(pets.union(pets2))

// 2
print("\nChallenge 2:")
print(pets.intersection(pets2))

// 3
print("\nChallenge 3:")
if let removedPet = pets.remove("Mango"){
    print(removedPet)
}

// 4
print("\nChallenge 4:")
pets2.formUnion(pets)
print(pets2)
