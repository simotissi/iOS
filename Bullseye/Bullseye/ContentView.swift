//
//  ContentView.swift
//  Bullseye
//
//  Created by Simone Tissi on 14/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var valueSlider = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var body: some View{
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")

            }
            
            Spacer()
            // SLIDER row
            HStack{
                Text("1")
                Slider(value: $valueSlider, in: 1...100)
                Text("100")
            }
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
                
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $alertIsVisible){() ->
                Alert in
                return Alert(title: Text(alertTitle()), message: Text("This slider value is \(sliderValueRounded()).\n" + "You scored \(pointsForCurrentRound()) this round."),
                             dismissButton: .default(Text("Awesome")){
                                self.score = self.score + self.pointsForCurrentRound()
                                self.target = Int.random(in: 1...100)
                                self.round += 1
                            })
            }
            Spacer()
            // Score row
            HStack{
                Button(action: {
                    self.score = 0
                    self.round = 1
                    self.target = Int.random(in: 1...100)
                }){Text("Start Over")}
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                Button(action: {}){Text("Info")}
            }
            .padding(.bottom, 20)
        }
    }
    
    func amountOff() -> Int {
        return abs(target-sliderValueRounded())
    }
    func sliderValueRounded() -> Int {
        return Int(valueSlider.rounded())
    }
    func pointsForCurrentRound() -> Int {
        return 100-amountOff()
    }
    
    func alertTitle() -> String{
        let diff = amountOff()
        let title: String
        if diff == 0{
            title = "Perfect!"
        }else if diff<=5 {
            title = "You almost made it!"
        }else{
            title = "Try again, loser!"
        }
        return title
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
