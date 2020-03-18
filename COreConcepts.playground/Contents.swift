
import Cocoa

let daysWeek: [String] = ["Dom","Lun","Mar","Mer","Gio","Ven","Sab"]
let poolTemp: [Int] = [23,45,34,65,44,12,56]

for i in 0..<daysWeek.count{
    if daysWeek[i] == "Ven" {
        print("OH YES")
        continue
    }
    print("\(daysWeek[i]): \(poolTemp[i])")
}

for _ in 1...5{
    for _ in 1...10{
        print("*", terminator: "")
    }
    print("")
}

let pastries = ["Biscotti","Cioccolata","Cereali","Torta","Brownie","Porridge","Pip","Pappa"]

for pastry in pastries {
    if pastry.count > 5 {
        continue
    }
    print(pastry)
}

for day in daysWeek{
    if day == "Dom"{continue}
    print(day)
    if day == "Ven"{break}
}
